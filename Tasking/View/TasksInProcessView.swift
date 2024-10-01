//
//  TasksInProcessView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/10/24.
//

import SwiftUI

struct TasksInProcessView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.allPriorityTasks) { task in
                    HStack {
                        Text(task.name)
                            .foregroundColor(task.priority?.color ?? .black)
                        Spacer()
                    }
                    .background(task.priority?.color.opacity(0.2) ?? Color.clear)
                    .contextMenu {
                        Button(action: {
                            taskManager.shareTask(task)
                            taskManager.moveTaskToCompleted(task)
                        }) {
                            Text("Schedule it in calendar")
                            Image(systemName: "calendar")
                        }
                        Button(action: {
                            taskManager.shareTask(task)
                            taskManager.moveTaskToCompleted(task)
                        }) {
                            Text("Ask to")
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
                .onDelete(perform: deleteTasks)
                .onMove(perform: moveTasks)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Tasks In Process")
                        .font(.custom("Noteworthy-Bold", size: 34))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        offsets.map { taskManager.allPriorityTasks[$0] }.forEach { task in
            taskManager.removeTask(with: task.id)
        }
    }
    
    private func moveTasks(from source: IndexSet, to destination: Int) {
        var tasksToMove: [Task] = []
        for index in source {
            let task = taskManager.allPriorityTasks[index]
            tasksToMove.append(task)
        }

        for task in tasksToMove {
            taskManager.removeTask(with: task.id)
        }

        for (offset, task) in tasksToMove.enumerated() {
            let newIndex = destination > source.first! ? destination - offset : destination + offset
            taskManager.tasks.insert(task, at: newIndex)
        }

        taskManager.sortTasksByPriority()
    }
}
