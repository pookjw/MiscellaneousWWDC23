//
//  NumberViewModel.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/8/23.
//

import Foundation
import Observation

actor NumberViewModel: Observable {
    // MARK: - Number
    
    private let _numberStorage: UnsafeMutablePointer<Int> = .allocate(capacity: 1)
    private nonisolated var _number: Int {
        get {
            observationRegistrar.access(self, keyPath: \._number)
            return _numberStorage.pointee
        }
        set {
            observationRegistrar.withMutation(of: self, keyPath: \._number) {
                observationRegistrar.willSet(self, keyPath: \._number)
                _numberStorage.pointee = newValue
                observationRegistrar.didSet(self, keyPath: \._number)
            }
        }
    }
    
    @MainActor
    var number: Int {
        get {
            _number
        }
        set {
            _number = newValue
        }
    }
    
    // MARK: - Observations
    
    var numberStream: AsyncStream<Int> {
        let key: UUID = .init()
        let (stream, continuation): (AsyncStream<Int>, AsyncStream<Int>.Continuation) = AsyncStream<Int>.makeStream()
        
        let task: Task = .init {
            set(numberContinuation: continuation, key: key)
            
            observePaths { paths in
                guard !Task.isCancelled else {
                    return false
                }
                
                continuation.yield(paths)
                return true
            }
        }
        
        continuation.onTermination = { [weak self] _ in
            task.cancel()
            Task { [self] in
                await self?.removeNumberContinuation(key: key)
            }
        }
        
        return stream
    }
    
    private let observationRegistrar: ObservationRegistrar = .init()
    
    private func observePaths(onChange: @Sendable @escaping (Int) -> Bool) {
        withObservationTracking {
            observationRegistrar.access(self, keyPath: \._number)
        } onChange: { [weak self] in
            Task { [self] in
                guard let number: Int = await self?.number else {
                    return
                }
                
                guard onChange(number) else { return }
                await self?.observePaths(onChange: onChange)
            }
        }
    }
    
    // MARK: - Continuations
    
    private var numberContinuations: [UUID: AsyncStream<Int>.Continuation] = .init()
    
    private func set(numberContinuation: AsyncStream<Int>.Continuation, key: UUID) {
        numberContinuations[key] = numberContinuation
    }
    
    private func removeNumberContinuation(key: UUID) {
        numberContinuations.removeValue(forKey: key)
    }
    
    deinit {
        numberContinuations
            .values
            .forEach { $0.finish() }
        
        _numberStorage.deallocate()
    }
}
