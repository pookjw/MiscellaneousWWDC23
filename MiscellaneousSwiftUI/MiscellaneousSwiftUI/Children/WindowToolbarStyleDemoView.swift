//
//  WindowToolbarStyleDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/26/23.
//

import SwiftUI

enum WindowToolbarStyleDemo {
    static let automaticWindow: some Scene = WindowGroup("DefaultWindowToolbarStyle", id: "DefaultWindowToolbarStyle") {
        DismissWindowDemoView()
    }
    #if os(macOS)
        .windowToolbarStyle(.automatic)
    #endif
    
    static let expandedWindow: some Scene = WindowGroup("ExpandedWindowToolbarStyle", id: "ExpandedWindowToolbarStyle") {
        DismissWindowDemoView()
    }
    #if os(macOS)
        .windowToolbarStyle(.expanded)
    #endif
    
    struct ContentView: View {
        @Environment(\.openWindow) private var openWindow: OpenWindowAction
        
        var body: some View {
            VStack {
                Button("DefaultWindowToolbarStyle") {
                    openWindow(id: "DefaultWindowToolbarStyle")
                }
                
                Button("ExpandedWindowToolbarStyle") {
                    openWindow(id: "ExpandedWindowToolbarStyle")
                }
            }
        }
    }
}

#Preview {
    WindowToolbarStyleDemo.ContentView()
}
