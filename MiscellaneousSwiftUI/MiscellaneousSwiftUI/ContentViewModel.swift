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
    
    init() {
        withObservationTracking {
            _$observationRegistrar.access(self, keyPath: \.paths)
        } onChange: {
            withObservationTracking {
                self._$observationRegistrar.access(self, keyPath: \.paths)
            } onChange: {
                print("Test 2")
            }
        }
    }
}
