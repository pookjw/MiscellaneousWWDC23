//
//  ItemView.swift
//  Publisher
//
//  Created by Jinwoo Kim on 7/8/23.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    @State private var item: Item
    
    init(item: Item) {
        _item = .init(initialValue: item)
    }
    
    var body: some View {
        TextEditor(text: $item.text)
            .background { Color.secondary }
            .navigationTitle(item.objectID.storeIdentifier ?? .init())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
    }
}

#Preview {
    ItemView(item: .init(uniqueID: .init(), text: "Test"))
}
