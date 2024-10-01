//
//  TasksInProcessView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/10/24.
//

import SwiftUI

struct TasksInProcessView: View {
    @EnvironmentObject private var taskManager: TaskManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.allPriorityTasks) { task in
                    HStack {
                        Text(task.name)
                            .foregroundColor(task.priority?.color ?? .black) // Set text color based on priority
                        Spacer()
                    }
                    .background(task.priority?.color.opacity(0.2) ?? Color.clear) // Set row background based on priority
                    .contextMenu {
                        Button(action: {
                            // Action to edit the task
                        }) {
                            Text("Edit")
                        }
                        Button(action: {
                            // Action to delete the task
                            taskManager.removeTask(with: task.id)
                        }) {
                            Text("Delete")
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
            // Gather tasks to move
            var tasksToMove: [Task] = []
            for index in source {
                let task = taskManager.allPriorityTasks[index]
                tasksToMove.append(task)
            }

            // Remove tasks from the current list
            for task in tasksToMove {
                taskManager.removeTask(with: task.id)
            }

            // Insert tasks into the new position
            for (offset, task) in tasksToMove.enumerated() {
                let newIndex = destination > source.first! ? destination - offset : destination + offset
                taskManager.tasks.insert(task, at: newIndex)
            }

            // Sort tasks to maintain priority order
            taskManager.sortTasksByPriority()
        }
    }
