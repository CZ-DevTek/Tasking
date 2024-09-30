//
//  CustomList.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/10/24.
//

import SwiftUI

struct CustomList<Item: Identifiable & Equatable>: View {
    @Binding var items: [Item]
    var deleteAction: (Item) -> Void
    var updateAction: (Item, String) -> Void
    var labelForItem: (Item) -> String
    var moveAction: (IndexSet, Int) -> Void

    @State private var editingItemID: Item.ID?
    @State private var updatedText = ""

    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                HStack {
                    if editingItemID == item.id {
                        TextField("Edit item", text: $updatedText, onCommit: {
                            updateAction(item, updatedText)
                            editingItemID = nil
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            updatedText = labelForItem(item)
                        }
                    } else {
                        Text(labelForItem(item))
                    }
                    
                    Spacer()
                }
                .onDrag {
                    NSItemProvider(object: labelForItem(item) as NSString)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(
                    Capsule()
                        .fill(.white)
                        .padding(2)
                )
                .swipeActions(edge: .trailing) {
                    Button {
                        editingItemID = item.id
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.blue)

                    Button(role: .destructive) {
                        deleteAction(item)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .onMove(perform: moveAction)
        }
        .scrollContentBackground(.hidden)
        .background(.gray.opacity(0.2))
        .cornerRadius(20)
        .padding()
        .toolbar {
            EditButton() // Required for enabling drag-and-drop reordering
        }
    }
}


