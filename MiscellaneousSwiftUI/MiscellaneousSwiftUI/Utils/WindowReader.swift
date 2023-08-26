//
//  WindowReader.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/26/23.
//

import SwiftUI

#if os(macOS)
struct WindowReader: NSViewRepresentable {
    @MainActor final class ContentView: NSView {
        fileprivate var handler: (@MainActor (NSWindow?) -> Void)?
        
        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            handler?(window)
        }
    }
    
    private let handler: @MainActor (NSWindow?) -> Void
    
    init(handler: @escaping @MainActor (NSWindow?) -> Void) {
        self.handler = handler
    }
    
    func makeNSView(context: Context) -> ContentView {
        .init()
    }
    
    func updateNSView(_ nsView: ContentView, context: Context) {
        nsView.handler = handler
    }
}
#else
struct WindowReader: UIViewRepresentable {
    @MainActor final class ContentView: UIView {
        fileprivate var handler: (@MainActor (UIWindow?) -> Void)?
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            handler?(window)
        }
    }
    
    private let handler: @MainActor (UIWindow?) -> Void
    
    init(handler: @escaping @MainActor (UIWindow?) -> Void) {
        self.handler = handler
    }
    
    func makeUIView(context: Context) -> ContentView {
        .init()
    }
    
    func updateUIView(_ uiView: ContentView, context: Context) {
        uiView.handler = handler
    }
}
#endif
