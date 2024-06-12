//
//  PriorityView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PriorityView: View {
    @ObservedObject private var taskManager = TaskManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(taskManager.tasks, id: \.self) { task in
                        HStack {
                            Text(task.name)
                            Spacer()
                            Button(action: {
                                if let index = taskManager.tasks.firstIndex(of: task) {
                                    taskManager.removeTask(at: index)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .onDrag {
                            NSItemProvider(object: task.name as NSString)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                
                VStack {
                    HStack {
                        PriorityButton(priority: .importantButNotUrgent,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks?[.importantButNotUrgent] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks?[.importantButNotUrgent] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .blue,
                                       taskManager: taskManager)
                        PriorityButton(priority: .importantAndUrgent,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks?[.importantAndUrgent] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks?[.importantAndUrgent] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .red,
                                       taskManager: taskManager)
                    }
                    HStack {
                        PriorityButton(priority: .notImportantNotUrgent,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks?[.notImportantNotUrgent] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks?[.notImportantNotUrgent] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .green,
                                       taskManager: taskManager)
                        PriorityButton(priority: .urgentButNotImportant,
                                       tasks: Binding(
                                        get: { taskManager.priorityTasks?[.urgentButNotImportant] ?? [] },
                                        set: { newValue in
                                            taskManager.priorityTasks?[.urgentButNotImportant] = newValue
                                        }
                                       ),
                                       allTasks: $taskManager.tasks,
                                       color: .gray,
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
    }
}
