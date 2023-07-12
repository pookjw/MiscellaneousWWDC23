//
//  ItemsView.swift
//  Publisher
//
//  Created by Jinwoo Kim on 7/8/23.
//

import SwiftUI
import SwiftData

struct ItemsView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @Query private var items: [Item]
    @State private var selectedItem: Item?
    
    var body: some View {
        List(items, id: \.self, selection: $selectedItem) { item in
            Text(String(describing: item))
        }
        .navigationTitle(ProcessInfo.processInfo.processName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let item: Item = .init(uniqueID: .init(), text: .init())
                    try! context.transaction {
                        context.insert(item)
                        try context.save()
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(item: $selectedItem) { item in
            NavigationStack {
                ItemView(item: item)
            }
        }
    }
}

#Preview {
    ItemsView()
}
