//
//  PriorityView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PriorityView: View {
    @EnvironmentObject private var taskManager: TaskManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomList(
                    items: $taskManager.tasks,
                    deleteAction: { task in
                        taskManager.removeTask(with: task.id)
                    },
                    updateAction: { task, newName in
                        taskManager.updateTask(id: task.id, newName: newName)
                    },
                    labelForItem: { task in
                        task.name
                    },
                    moveAction: { indices, newOffset in
                        taskManager.moveTasks(fromOffsets: indices, toOffset: newOffset)
                    }
                )
                
                .frame(maxHeight: .infinity)
                
                // Lower half: Priority matrix
                VStack {
                    HStack {
                        PriorityMatrixView(priority: .importantAndUrgent,
                                           tasks: Binding(
                                            get: { taskManager.priorityTasks[.importantAndUrgent] ?? [] },
                                            set: { newValue in
                                                taskManager.priorityTasks[.importantAndUrgent] = newValue
                                            }
                                           ),
                                           allTasks: $taskManager.tasks,
                                           color: .clear,
                                           taskManager: taskManager)
                        .gradientBackground(for: .green)
                        .padding(.bottom)
                        
                        PriorityMatrixView(priority: .importantButNotUrgent,
                                           tasks: Binding(
                                            get: { taskManager.priorityTasks[.importantButNotUrgent] ?? [] },
                                            set: { newValue in
                                                taskManager.priorityTasks[.importantButNotUrgent] = newValue
                                            }
                                           ),
                                           allTasks: $taskManager.tasks,
                                           color: .clear,
                                           taskManager: taskManager)
                        .gradientBackground(for: .yellow)
                        .padding(.bottom)
                    }
                    Spacer()
                    
                    HStack {
                        PriorityMatrixView(priority: .urgentButNotImportant,
                                           tasks: Binding(
                                            get: { taskManager.priorityTasks[.urgentButNotImportant] ?? [] },
                                            set: { newValue in
                                                taskManager.priorityTasks[.urgentButNotImportant] = newValue
                                            }
                                           ),
                                           allTasks: $taskManager.tasks,
                                           color: .clear,
                                           taskManager: taskManager)
                        .gradientBackground(for: .blue)
                        
                        PriorityMatrixView(priority: .notImportantNotUrgent,
                                           tasks: Binding(
                                            get: { taskManager.priorityTasks[.notImportantNotUrgent] ?? [] },
                                            set: { newValue in
                                                taskManager.priorityTasks[.notImportantNotUrgent] = newValue
                                            }
                                           ),
                                           allTasks: $taskManager.tasks,
                                           color: .clear,
                                           taskManager: taskManager)
                        .gradientBackground(for: .red)
                    }
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
            .customizeBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Priority Matrix")
                        .font(CustomFont.title.font)
                        .foregroundColor(CustomFont.title.color)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 8)
                }
            }
        }
    }
}

struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityView()
            .environmentObject(TaskManager())
    }
}
