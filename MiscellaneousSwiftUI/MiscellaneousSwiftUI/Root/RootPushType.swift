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
    case settingsLink
    case openWindow
    case windowStyles
    case windowToolbarStyle
    
    var id: Int {
        rawValue
    }
    
    var text: String {
        switch self {
        case .appStorage:
            "AppStorageDemoView"
        case .sceneStorage:
            "SceneStorageDemoView"
        case .settingsLink:
            "SettingsLinkDemoView"
        case .openWindow:
            "OpenWindowDemoView"
        case .windowStyles:
            "WindowStylesDemoView"
        case .windowToolbarStyle:
            "WindowToolbarStyleDemoView"
        }
    }
    
    var body: some View {
        Group {
            switch self {
            case .appStorage:
                AppStorageDemoView()
            case .sceneStorage:
                SceneStorageDemoView()
            case .settingsLink:
                SettingsLinkDemoView()
            case .openWindow:
                OpenWindowDemoView()
            case .windowStyles:
                WindowStylesDemoView()
            case .windowToolbarStyle:
                WindowToolbarStyleDemo.ContentView()
            }
        }
    }
}
