//
//  DoItNowView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct DoItNowView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = true

    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach(taskManager.doItNowTasks) { task in
                        TapToCompleteTask(
                            task: task,
                            color: .customGreen,
                            font: CustomFont.body.font
                        ) {
                            withAnimation {
                                taskManager.moveTaskToCompleted(task)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Rectangle()
                                .fill(.green)
                                .padding(2)
                                .cornerRadius(15)
                        )
                        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            indexSet.forEach { index in
                                let task = taskManager.doItNowTasks[index]
                                taskManager.removeTaskFromCurrentList(task)
                            }
                        }
                    }
                    .onMove { source, destination in
                        taskManager.doItNowTasks.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(.clear)
                .onDisappear {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .cornerRadius(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Do It Now")
                        .font(CustomFont.title.font)
                        .foregroundColor(.customGreen)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            FoldingButtonBar(isExpanded: $isExpanded)
                .padding(.bottom, 8)
        }
        .padding()
        .customizeSubviewsBackground(for: .green)
    }
}

struct DoItNowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DoItNowView()
                .environmentObject(TaskManager())
        }
    }
}
