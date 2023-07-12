//
//  RootView.swift
//  Publisher
//
//  Created by Jinwoo Kim on 7/8/23.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var viewModel: RootViewModel = .init()
    
    var body: some View {
        NavigationStack {
            if let modelContext: ModelContext = viewModel.modelContext {
                ItemsView()
                    .environment(\.modelContext, modelContext)
            } else {
                ContentUnavailableView.search
            }
        }
        .task {
            try! await viewModel.load()
        }
    }
}

#Preview {
    RootView()
}
