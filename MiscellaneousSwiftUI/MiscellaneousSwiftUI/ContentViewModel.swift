//
//  ContentViewModel.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/7/23.
//

import Foundation
import Observation

@Observable
final class ContentViewModel {
    var paths: [MSPath] = .init()
    
    var pathsStream: AsyncStream<[MSPath]> {
        let (stream, continuation): (AsyncStream<[MSPath]>, AsyncStream<[MSPath]>.Continuation) = AsyncStream<[MSPath]>.makeStream()
        
        let task: Task = .init {
            observePaths { paths in
                guard !Task.isCancelled else {
                    return false
                }
                
                continuation.yield(paths)
                return true
            }
        }
        
        continuation.onTermination = { _ in
            task.cancel()
        }
        
        return stream
    }
    
    private func observePaths(onChange: @Sendable @escaping ([MSPath]) -> Bool) {
        withObservationTracking { 
            _$observationRegistrar.access(self, keyPath: \.paths)
        } onChange: { [weak self] in
            guard let paths: [MSPath] = self?.paths else { return }
            
            guard onChange(paths) else { return }
            self?.observePaths(onChange: onChange)
        }
    }
}
