//
//  RootPushType.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/17/23.
//

import SwiftUI

enum RootPushType: Int, CaseIterable, Identifiable, Codable, Sendable {
    case appStorage
    case sceneStorage
    
    var id: Int {
        rawValue
    }
    
    var text: String {
        switch self {
        case .appStorage:
            "AppStorage"
        case .sceneStorage:
            "SceneStorage"
        }
    }
    
    var body: some View {
        Group {
            switch self {
            case .appStorage:
                AppStorageDemoView()
            case .sceneStorage:
                SceneStorageDemoView()
            }
        }
    }
}
