//
//  RootView.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/17/23.
//

import SwiftUI

struct RootView: View {
    @Environment(\.scenePhase) private var scenePhase: ScenePhase
    @State private var viewModel: RootViewModel = .init()
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List(RootPushType.allCases) { type in
                NavigationLink(value: type) {
                    Text(type.text)
                }
            }
            .navigationDestination(for: RootPushType.self) { type in
                type.body
            }
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .background {
                try! viewModel.save()
            }
        }
    }
}

#Preview {
    RootView()
}
