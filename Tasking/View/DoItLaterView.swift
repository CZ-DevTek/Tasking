//
//  DoItLaterView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct DoItLaterView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var tasks: [Task]
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = true
    
    var body: some View {
        VStack {
            List {
                ForEach(taskManager.doItLaterTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(CustomFont.body.font)
                            .foregroundColor(.customRed)
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(
                            action: {
                                taskManager
                                    .moveTaskToPriorityLists(
                                        task,
                                        priority: .importantAndUrgent
                                    )
                            }) {
                                Label(
                                    NSLocalizedString(
                                        "Move to Do It Now",
                                        comment: "Move to Do It Now"
                                    ),
                                    systemImage: "arrow.right.circle"
                                )
                            }
                        
                        Button(
                            action: {
                                taskManager
                                    .moveTaskToPriorityLists(
                                        task,
                                        priority: .importantButNotUrgent
                                    )
                            }) {
                                Label(
                                    NSLocalizedString(
                                        "Move to Schedule It",
                                        comment: "Move to Schedule It"
                                    ),
                                    systemImage: "calendar"
                                )
                            }
                        
                        Button(
                            action: {
                                taskManager
                                    .moveTaskToPriorityLists(
                                        task,
                                        priority: .urgentButNotImportant
                                    )
                            }) {
                                Label(
                                    NSLocalizedString(
                                        "Move to Delegate It",
                                        comment: "Move to Delegate It"
                                    ),
                                    systemImage: "person.crop.circle.badge.checkmark"
                                )
                            }
                        
                        Button(
                            action: {
                                taskManager
                                    .removeTaskFromCurrentList(
                                        task
                                    )
                                taskManager
                                    .saveTasks()
                            }) {
                                Label(
                                    NSLocalizedString(
                                        "Delete Task",
                                        comment: "Delete Task"
                                    ),
                                    systemImage: "trash"
                                )
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(Color.red)
                            .padding(2)
                            .cornerRadius(15)
                    )
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                taskManager.removeTaskFromCurrentList(task)
                                taskManager.saveTasks()
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let task = taskManager.doItLaterTasks[index]
                        taskManager.removeTaskFromCurrentList(task)
                        taskManager.saveTasks()
                    }
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .cornerRadius(20)
            
            Spacer()
            
            FoldingButtonBarView(isExpanded: $isExpanded)
                .padding(.bottom, 8)
        }
        .padding()
        .customizeSubviewsBackground(for: .red)
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(NSLocalizedString("Do It Later", comment: "Do It Later"))
                    .font(CustomFont.title.font)
                    .foregroundColor(.customRed)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
