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
    
    private var pathsStream: AsyncStream<[MSPath]> {
        let (stream, continuation): (AsyncStream<[MSPath]>, AsyncStream<[MSPath]>.Continuation) = AsyncStream<[MSPath]>.makeStream()
        
        var cancelled: Bool = false
        continuation.onTermination = { _ in
            cancelled = true
        }
        observePaths { paths in
            continuation.yield(paths)
        }
        
        return stream
    }
    
    init() {
        
    }
    
    private func observePaths(onChange: @Sendable @escaping ([MSPath]) async -> Bool) {
        withObservationTracking { 
            _$observationRegistrar.access(self, keyPath: \.paths)
        } onChange: { [weak self] in
            guard let paths: [MSPath] = self?.paths else { return }
            
            Task { [self] in
                let result: Bool = await onChange(paths)
                guard result else { return }
                self?.observePaths(onChange: onChange)
            }
        }
    }
}
