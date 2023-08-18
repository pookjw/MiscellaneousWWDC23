//
//  TransformEnvironmentDemoView.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI

struct TransformEnvironmentDemoView: View {
    @State private var increment: Int = .zero
    
    var body: some View {
        VStack {
            Button("Increment") {
                increment += 1
            }
            
            _View()
                .transformEnvironment(\.transformEnvironmentDemoValue) {
                    $0 += increment
                }
        }
    }
}

private struct _View: View {
    @Environment(\.transformEnvironmentDemoValue) private var number: Int
    
    var body: some View {
        Text(String(describing: number)) // 3000
    }
}

private struct MyEnvironmentKey: EnvironmentKey {
    static let defaultValue: Int = 1
}

extension EnvironmentValues {
    var transformEnvironmentDemoValue: Int {
        get {
            self[MyEnvironmentKey.self]
        }
        set {
            self[MyEnvironmentKey.self] = newValue
        }
    }
}

#Preview {
    TransformEnvironmentDemoView()
}
