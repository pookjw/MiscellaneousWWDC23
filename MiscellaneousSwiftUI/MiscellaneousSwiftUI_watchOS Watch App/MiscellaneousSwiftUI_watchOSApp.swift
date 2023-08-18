//
//  MiscellaneousSwiftUI_watchOSApp.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/17/23.
//

import SwiftUI

@main
struct MiscellaneousSwiftUI_watchOS_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
