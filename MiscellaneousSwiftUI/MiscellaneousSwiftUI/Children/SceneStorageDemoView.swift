//
//  SceneStorageDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI

struct SceneStorageDemoView: View {
    @SceneStorage("count") private var count: Int = .zero
    @State private var sceneStorage: SceneStorage<Int> = .init(wrappedValue: .zero, "count")
    
    var body: some View {
        VStack {
            Text(String(describing: count))
            Stepper(value: $count) {}
        }
//        VStack {
//            Text(String(describing: sceneStorage.wrappedValue))
//            Stepper(value: sceneStorage.projectedValue) {}
//        }
//        .onAppear {
//            print(URL.documentsDirectory)
//        }
//        .onChange(of: sceneStorage.wrappedValue) { _, _ in
//            sceneStorage.update()
//            sceneStorage._domain
//            
//            
//        }
    }
}

#Preview {
    SceneStorageDemoView()
}
