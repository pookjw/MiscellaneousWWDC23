//
//  ContentView.swift
//  MiscellaneousTipKit
//
//  Created by Jinwoo Kim on 7/28/23.
//

import SwiftUI
import TipKit

struct ContentView: View {
    var body: some View {
        List {
            NavigationLink {
                SwiftUIDemoView()
            } label: {
                Label("SwiftUI", systemImage: "arrow.up.doc.on.clipboard")
                    .symbolEffect(.pulse.byLayer, options: .repeating)
            }

            NavigationLink {
                UIKitSwiftDemoViewController_SwiftUI()
                    .ignoresSafeArea()
            } label: {
                Label("UIKit (Swift)", systemImage: "arrow.up.doc.on.clipboard")
                    .symbolEffect(.variableColor.cumulative, options: .repeating)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Configure") {
                    Task {
                        try! await Tips.configure {
                            DisplayFrequency(.immediate)
                            DatastoreLocation(url: .temporaryDirectory, shouldReset: true)
                        }
                        
                        print(URL.temporaryDirectory)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
