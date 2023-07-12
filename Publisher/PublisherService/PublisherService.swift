//
//  PublisherService.swift
//  PublisherService
//
//  Created by Jinwoo Kim on 7/12/23.
//

import Foundation
import SwiftUI
import ExtensionFoundation
import ExtensionKit
import Common

protocol PublisherServiceExtension: AppExtension {
    func transform(_ input: String) async -> String
}

@main
struct PublisherService: PublisherServiceExtension {
    var configuration: AppExtensionSceneConfiguration {
        let configuration: PublisherServiceConfiguration<Self> = .init(appExtension: self)
        let scene: PrimitiveAppExtensionScene = .init(id: sceneID) {
            Color.purple
        } onConnection: { connection in
            connection.activate()
            return true
        }

        return .init(scene, configuration: configuration)
    }
    
    func transform(_ input: String) async -> String {
        "BOO!"
    }
}
