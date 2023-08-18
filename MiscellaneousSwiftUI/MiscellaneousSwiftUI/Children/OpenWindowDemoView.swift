//
//  OpenWindowDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI

struct OpenWindowDemoView: View {
    @Environment(\.openWindow) private var openWindow: OpenWindowAction
    
    var body: some View {
        VStack {
            Button("OpenWindowAction") {
                openWindow(id: "DemoWindowGroup_1")
            }
        }
    }
}

#Preview {
    OpenWindowDemoView()
}
