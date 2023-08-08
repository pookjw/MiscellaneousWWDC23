//
//  SwiftUIDemoView.swift
//  MiscellaneousTipKit
//
//  Created by Jinwoo Kim on 7/28/23.
//

import SwiftUI
import TipKit

struct SwiftUIDemoView_Tip: Tip {
    var title: Text {
        Text("Hello World!")
            .italic()
    }
    
    var actions: [Action] {
        [
            .init(title: "Test") {
                print("")
            }
        ]
    }
}

struct SwiftUIDemoView: View {
    let tip: SwiftUIDemoView_Tip = .init()
    
    var body: some View {
        VStack {
            TipView(tip, arrowEdge: .bottom) { action in
                print(action)
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            print(SwiftUIDemoView_Tip().id)
        }
    }
}

#Preview {
    SwiftUIDemoView()
}
