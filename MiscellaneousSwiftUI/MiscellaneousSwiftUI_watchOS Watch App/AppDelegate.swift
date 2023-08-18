//
//  AppDelegate.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/17/23.
//

import WatchKit

@Observable
final class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidBecomeActive() {
        
    }
    
    func foo() {
        print("Foo!")
    }
}
