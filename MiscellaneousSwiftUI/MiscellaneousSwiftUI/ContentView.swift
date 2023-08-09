//
//  ContentView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: ContentViewModel = .init()
    @SceneStorage("pathsData") private var pathsData: Data?
    
    var body: some View {
        NavigationStack(path: $viewModel.paths) {
            List(MSPath.allCases) { path in
                NavigationLink(value: path) {
                    Text(path.rawValue)
                }
                
            }
            .navigationDestination(for: MSPath.self) { path in
                switch path {
                case .dismissWindowAction:
                    DismissWindowActionView()
                case .nunber:
                    NumberView()
                }
            }
            .navigationTitle("MiscellaneousSwiftUI")
        }
        
    }
}

#Preview {
    ContentView()
}
