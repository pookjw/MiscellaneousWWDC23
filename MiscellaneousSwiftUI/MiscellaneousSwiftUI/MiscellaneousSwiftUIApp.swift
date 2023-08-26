//
//  MiscellaneousSwiftUIApp.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/17/23.
//

import SwiftUI

@main
struct MiscellaneousSwiftUIApp: App {
    var body: some Scene {
        WindowGroup(id: "default") {
            RootView()
        }
        .defaultSize(width: 300.0, height: 300.0)
        
        WindowGroup(id: "DemoWindowGroup_1") {
            DismissWindowDemoView()
        }
        
        automaticWindow
        hiddenTitleBarWindow
        plainWindow
        titleBarWindow
        volumetricWindow
        customWindow
        
#if os(macOS)
        Settings {
            RootView()
        }
#endif
    }
}
