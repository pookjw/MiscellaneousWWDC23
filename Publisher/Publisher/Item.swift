//
//  Item.swift
//  Publisher
//
//  Created by Jinwoo Kim on 7/8/23.
//

import Foundation
import SwiftData
import Observation

//@Model
//final class Item {
//    @Attribute([.unique]) let uniqueID: UUID
//    @Attribute var text: String
//    
//    init(uniqueID: UUID, text: String) {
//        self.uniqueID = uniqueID
//        self.text = text
//    }
//}

actor Item: PersistentModel, ModelActor, Observable {
    static var executor: DefaultModelExecutor!
    nonisolated var executor: any ModelExecutor { Self.executor }
    
    static func schemaMetadata() -> [(String, AnyKeyPath, Any?, Any?)] {
        [
            ("uniqueID", \Item.uniqueID, nil, Attribute([.unique])),
            ("text", \Item._text, nil, nil)
        ]
    }
    
    private let _backingData: UnsafeMutablePointer<DefaultBackingData<Item>> = .allocate(capacity: 1)
    
    @ObservationIgnored
    nonisolated var backingData: any BackingData<Item> {
        get {
            _backingData.pointee
        }
        set {
            _backingData.pointee = newValue as! DefaultBackingData<Item>
        }
    }
    
    init(backingData: any BackingData<Item>) {
        _backingData.pointee = backingData as! DefaultBackingData<Item>
    }
    
    private let observationRegistrar: ObservationRegistrar = .init()
    
    nonisolated var uniqueID: UUID {
        backingData.getValue(for: \.uniqueID)
    }
    
    private nonisolated var _text: String {
        get {
            observationRegistrar.access(self, keyPath: \._text)
            return backingData.getValue(for: \._text)
        }
        set {
            observationRegistrar.withMutation(of: self, keyPath: \._text) {
                observationRegistrar.willSet(self, keyPath: \._text)
                backingData.setValue(for: \._text, to: newValue)
                observationRegistrar.didSet(self, keyPath: \._text)
            }
        }
    }
    
    @MainActor var text: String {
        get {
            _text
        }
        set {
            _text = newValue
        }
    }
    
    init(uniqueID: UUID, text: String) {
        backingData = DefaultBackingData(for: Item.self)
        backingData.setValue(for: \.uniqueID, to: uniqueID)
        _text = text
    }
    
    deinit {
        _backingData.deallocate()
    }
}
