//
//  DoItLaterView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DoItLaterView: View {
    @EnvironmentObject var taskManager: TaskManager
    @Binding var tasks: [Task]
    
    var body: some View {
        VStack {
            Text("DO IT LATER")
                .font(.largeTitle)
                .bold()
            
            List {
                ForEach(taskManager.doItLaterTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let task = taskManager.doItLaterTasks[index]
                        taskManager.removeTaskFromCurrentList(task)
                        taskManager.saveTasks()
                    }
                }
            }
            .navigationTitle("DO IT LATER")
        }
        .padding()
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
