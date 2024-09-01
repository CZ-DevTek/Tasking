//
//  ContentView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var taskManager: TaskManager
        @State private var newTaskName = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.tasks, id: \.self) { task in
                    HStack {
                        Text(task.name)
                        Spacer()
                        if let priority = task.priority {
                            Circle()
                                .fill(priority.color)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .onDrag {
                        NSItemProvider(object: task.name as NSString)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        taskManager.removeTask(at: index)
                    }
                }

                HStack {
                    TextField("Enter task name", text: $newTaskName)

                    Button("Add") {
                        if !newTaskName.isEmpty {
                            taskManager.addTask(Task(name: newTaskName))
                            newTaskName = ""
                        }
                    }
                }
            }
            .navigationTitle("Task List")
        }
    }
}

#Preview {
    TaskListView()
}
