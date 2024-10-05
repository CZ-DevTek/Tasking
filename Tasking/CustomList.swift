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
                VStack(spacing: 0) {
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
                                .font(CustomFont.body.font)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 2)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.blue.opacity(0.3))
                        .padding(.horizontal, 8)
                }
                .onDrag {
                    NSItemProvider(object: labelForItem(item) as NSString)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        deleteAction(item)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    Button {
                        editingItemID = item.id
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
            .onMove(perform: moveAction)
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .cornerRadius(20)
        .padding()
    }
}
