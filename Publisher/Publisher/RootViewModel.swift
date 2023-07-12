//
//  RootViewModel.swift
//  Publisher
//
//  Created by Jinwoo Kim on 7/8/23.
//

import Foundation
import SwiftData
import Observation
import UniformTypeIdentifiers
import Common

actor RootViewModel: Observable {
    private let _modelContext: UnsafeMutablePointer<ModelContext?> = .allocate(capacity: 1)
    @MainActor private(set) var modelContext: ModelContext? {
        get {
            observationRegistrar.access(self, keyPath: \.modelContext)
            return _modelContext.pointee
        }
        set {
            observationRegistrar.withMutation(of: self, keyPath: \.modelContext) {
                observationRegistrar.willSet(self, keyPath: \.modelContext)
                _modelContext.pointee = newValue
                observationRegistrar.didSet(self, keyPath: \.modelContext)
            }
        }
    }
    
    private let observationRegistrar: ObservationRegistrar = .init()
    
    deinit {
        _modelContext.deallocate()
    }
    
    func load() async throws {
        let modelConfiguration: ModelConfiguration = .init("Default", url: Common.containerURL, readOnly: false)
        let modelContainer: ModelContainer = try .init(for: Item.self, modelConfiguration)
        let modelContext: ModelContext = await modelContainer.mainContext
        modelContext.autosaveEnabled = true
        
        await MainActor.run {
            self.modelContext = modelContext
        }
    }
}
