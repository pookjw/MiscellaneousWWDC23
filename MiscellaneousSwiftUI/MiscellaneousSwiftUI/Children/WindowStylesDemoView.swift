//
//  WindowStylesDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/26/23.
//

import SwiftUI

//let _automaticWindow: some Scene = Windowgroup
let automaticWindow: some Scene = WindowGroup("DefaultWindowStyle", id: "DefaultWindowStyle") { 
    DismissWindowDemoView()
}
#if os(macOS) || os(visionOS)
.windowStyle(.automatic)
#endif

let hiddenTitleBarWindow: some Scene = WindowGroup("HiddenTitleBarWindowStyle", id: "HiddenTitleBarWindowStyle") { 
    DismissWindowDemoView()
}
#if os(macOS)
    .windowStyle(.hiddenTitleBar)
#endif

let plainWindow: some Scene = WindowGroup("PlainWindowStyle", id: "PlainWindowStyle") { 
    DismissWindowDemoView()
}
#if os(visionOS)
.windowStyle(.plain)
#endif

let titleBarWindow: some Scene = WindowGroup("TitleBarWindowStyle", id: "TitleBarWindowStyle") { 
    DismissWindowDemoView()
}
#if os(macOS)
    .windowStyle(.titleBar)
#endif

let volumetricWindow: some Scene = WindowGroup("VolumetricWindowStyle", id: "VolumetricWindowStyle") { 
    DismissWindowDemoView()
}
#if os(visionOS)
    .windowStyle(.volumetric)
#endif

let customWindow: some Scene = WindowGroup("customWindow", id: "customWindow") {
    DismissWindowDemoView()
        .background { 
            WindowReader { window in
#if os(macOS) && !targetEnvironment(macCatalyst)
                guard let window: NSWindow else {
                    return
                }   
                
                window.styleMask = [.closable, .titled, .resizable, .fullSizeContentView]
                window.titlebarSeparatorStyle = .shadow
                window.titlebarAppearsTransparent = true
#elseif targetEnvironment(macCatalyst)
//                guard let titleBar = window?.windowScene?.perform(Selector(("titlebar"))).takeRetainedValue() else {
//                    return
//                }
                
                guard let titleBar: UITitlebar = window?.windowScene?.titlebar else {
                    return
                }
                
                titleBar.titleVisibility = .hidden
#endif
            }
        }
}

struct WindowStylesDemoView: View {
    @Environment(\.openWindow) private var openWindow: OpenWindowAction
    
    var body: some View {
        VStack {
            Button("DefaultWindowStyle") { 
                openWindow(id: "DefaultWindowStyle")
            }
            
            Button("HiddenTitleBarWindowStyle") { 
                openWindow(id: "HiddenTitleBarWindowStyle")
            }
            
            Button("PlainWindowStyle") { 
                openWindow(id: "PlainWindowStyle")
            }
            
            Button("TitleBarWindowStyle") { 
                openWindow(id: "TitleBarWindowStyle")
            }
            
            Button("VolumetricWindowStyle") { 
                openWindow(id: "VolumetricWindowStyle")
            }
            
            Button("customWindow") { 
                openWindow(id: "customWindow")
            }
        }
    }
}

#Preview {
    WindowStylesDemoView()
}
