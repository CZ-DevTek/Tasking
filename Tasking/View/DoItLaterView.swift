//
//  DoItLaterView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DoItLaterView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var tasks: [Task]
    
    var body: some View {
        VStack {
            List {
                ForEach(taskManager.doItLaterTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(CustomFont.body.font)
                            .foregroundColor(Color.gray)
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        
                        Button(action: {
                            taskManager.moveTaskToPriorityList(task, priority: .importantAndUrgent)
                        }) {
                            Text("Move to Do It Now")
                            Image(systemName: "arrow.right.circle")
                        }
                        
                        Button(action: {
                            taskManager.moveTaskToPriorityList(task, priority: .importantButNotUrgent)
                        }) {
                            Text("Move to Schedule It")
                            Image(systemName: "calendar")
                        }
                        
                        Button(action: {
                            taskManager.moveTaskToPriorityList(task, priority: .urgentButNotImportant)
                        }) {
                            Text("Move to Delegate It")
                            Image(systemName: "person.crop.circle.badge.checkmark")
                        }
                        
                        Button(action: {
                            taskManager.removeTaskFromCurrentList(task)
                            taskManager.saveTasks()
                        }) {
                            Text("Delete Task")
                            Image(systemName: "trash")
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Capsule()
                            .fill(.white)
                            .padding(2)
                    )
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let task = taskManager.doItLaterTasks[index]
                        taskManager.removeTaskFromCurrentList(task)
                        taskManager.saveTasks()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.red.opacity(0.3))
            .cornerRadius(20)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Do It Later")
                        .font(CustomFont.title.font)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .padding()
        .background(.red.opacity(0.2))
    }
}

#Preview {
    let mockTasks = [
        Task(id: UUID(), name: "Task 1", priority: .importantAndUrgent),
        Task(id: UUID(), name: "Task 2", priority: .importantButNotUrgent),
        Task(id: UUID(), name: "Task 3", priority: .urgentButNotImportant)
    ]
    
    return DoItLaterView(tasks: .constant(mockTasks))
        .environmentObject(TaskManager())
}
