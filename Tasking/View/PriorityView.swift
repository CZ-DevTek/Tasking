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
                List {
                    ForEach(taskManager.tasks, id: \.self) { task in
                        HStack {
                            Text(task.name)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Capsule()
                                .fill(.white)
                                .padding(2)
                        )
                        .onDrag {
                            NSItemProvider(object: task.name as NSString)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .background(.gray.opacity(0.2))
                .cornerRadius(20)
                
                // Lower half: Priority matrix
                VStack {
                    HStack {
                        PriorityButton(priority: .importantAndUrgent,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks[.importantAndUrgent] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks[.importantAndUrgent] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .green,
                                       taskManager: taskManager)
                        PriorityButton(priority: .importantButNotUrgent,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks[.importantButNotUrgent] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks[.importantButNotUrgent] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .yellow,
                                       taskManager: taskManager)
                    }
                    HStack {
                        PriorityButton(priority: .urgentButNotImportant,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks[.urgentButNotImportant] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks[.urgentButNotImportant] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .blue,
                                       taskManager: taskManager)
                        PriorityButton(priority: .notImportantNotUrgent,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks[.notImportantNotUrgent] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks[.notImportantNotUrgent] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .red,
                                       taskManager: taskManager)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .padding()
        }
    }
}
struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityView()
            .environmentObject(TaskManager())
    }
}
