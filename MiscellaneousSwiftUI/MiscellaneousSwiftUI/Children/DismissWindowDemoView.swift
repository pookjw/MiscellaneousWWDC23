//
//  DismissWindowDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI

struct DismissWindowDemoView: View {
    @Environment(\.dismissWindow) private var dismissWindow: DismissWindowAction
    
    var body: some View {
        Button("DismissWindowAction") {
            dismissWindow()
        }
    }
}

#Preview {
    DismissWindowDemoView()
}
