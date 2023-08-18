//
//  RootPushType.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/17/23.
//

import SwiftUI

enum RootPushType: Int, CaseIterable, Identifiable, Codable, Sendable {
    case environmentDemo
    case transformEnvironment
    
    var id: Int {
        rawValue
    }
    
    var text: String {
        switch self {
        case .environmentDemo:
            "EnvironmentDemoView"
        case .transformEnvironment:
            "TransformEnvironmentDemoView"
        }
    }
    
    var body: some View {
        Group {
            switch self {
            case .environmentDemo:
                EnvironmentDemoView()
            case .transformEnvironment:
                TransformEnvironmentDemoView()
            }
        }
    }
}
