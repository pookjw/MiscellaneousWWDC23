//
//  PublisherServiceConfiguration.swift
//  PublisherService
//
//  Created by Jinwoo Kim on 7/12/23.
//

import Foundation
import ExtensionFoundation
import Common

private actor PublisherServiceObject: NSObject, PublisherServiceProtocol {
    let appExtension: any PublisherServiceExtension
    
    init(appExtension: any PublisherServiceExtension) {
        self.appExtension = appExtension
    }
    
    func transform(_ input: String) async -> String {
        await appExtension.transform(input)
    }
}

actor PublisherServiceConfiguration<E: PublisherServiceExtension>: AppExtensionConfiguration {
    private let appExtension: E
    private let publisherServiceObject: any PublisherServiceProtocol
    private var connection: NSXPCConnection?
    
    init(appExtension: E) {
        self.appExtension = appExtension
        publisherServiceObject = PublisherServiceObject(appExtension: appExtension)
    }
    
    nonisolated func accept(connection: NSXPCConnection) -> Bool {
        connection.exportedInterface = .init(with: PublisherServiceProtocol.self)
        connection.exportedObject = publisherServiceObject
//        connection.remoteObjectInterface
        
        Task {
            await self.connection?.invalidate()
            connection.activate()
            await set(connection: connection)
        }
        
        return true
    }
    
    private func set(connection: NSXPCConnection?) {
        self.connection = connection
    }
}
