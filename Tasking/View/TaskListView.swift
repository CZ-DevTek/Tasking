//
//  ContentView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var newTaskName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                CustomList(
                    items: $taskManager.tasks,
                    deleteAction: { task in
                        taskManager.removeTask(with: task.id)
                    },
                    updateAction: { task, newName in
                        taskManager.editTask(id: task.id, newName: newName)
                    },
                    labelForItem: { task in
                        task.name
                    },
                    moveAction: { indices, newOffset in
                        taskManager.moveTasks(fromOffsets: indices, toOffset: newOffset)
                    }
                )
                
                HStack {
                    TextField("Enter task name", text: $newTaskName)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .onSubmit {
                            addTask()
                        }
                }
                .padding()
                .padding(.bottom, 20)
                
            }
            .customizeBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Task List")
                        .font(CustomFont.title.font)
                        .foregroundColor(CustomFont.title.color)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 2)
                }
            }
        }
    }
    
    private func addTask() {
        if !newTaskName.isEmpty {
            taskManager.addTask(Task(name: newTaskName))
            newTaskName = ""
        }
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskManager())
}

