//
//  AppStorageDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI
import Photos

struct AppStorageDemoView: View {
//    @AppStorage("count") private var count: Int = .zero
    @State private var appStorage: AppStorage<Int> = .init(wrappedValue: .zero, "count", store: nil)
    
    var body: some View {
        VStack {
            Text(String(describing: appStorage.wrappedValue))
            Stepper(value: appStorage.projectedValue) {}
        }
        .onChange(of: appStorage.wrappedValue) { _, _ in
            appStorage.update()
        }
    }
}

#Preview {
    AppStorageDemoView()
}
