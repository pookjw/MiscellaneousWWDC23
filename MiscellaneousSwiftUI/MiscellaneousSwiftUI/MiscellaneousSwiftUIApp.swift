//
//  MiscellaneousSwiftUIApp.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/17/23.
//

import SwiftUI

@main
struct MiscellaneousSwiftUIApp: App {
    @SceneBuilder private var body_1: some Scene {
        WindowGroup(id: "default") {
            RootView()
        }
        
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
    }
    
    @SceneBuilder private  var body_2: some Scene {
        WindowToolbarStyleDemo.automaticWindow
        WindowToolbarStyleDemo.expandedWindow
        
#if os(macOS)
        MenuBarExtra("Test") {
            Text("Hello World!")
        }
        
        Settings {
            RootView()
        }
#endif
    }
    
    var body: some Scene {
        body_1
        body_2
    }
}
