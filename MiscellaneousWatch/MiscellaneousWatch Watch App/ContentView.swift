//
//  ContentView.swift
//  MiscellaneousWatch Watch App
//
//  Created by Jinwoo Kim on 6/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .containerBackground(.blue.gradient, for: .navigation)
        }
    }
}

#Preview {
    ContentView()
}
