//
//  SettingsLinkDemoView.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI

struct SettingsLinkDemoView: View {
    var body: some View {
#if os(macOS)
        SettingsLink {
            Text("Settings!")
        }
#else
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
#endif
    }
}

#Preview {
    SettingsLinkDemoView()
}
