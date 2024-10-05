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
            VStack {
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

                HStack {
                    TextField("Enter task name", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            addTask()
                        }
                }
                .padding()
                Spacer()

                VStack {
                    Text("After you write the tasks, take some minutes to establish priorities")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    Image(systemName: "arrow.down")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Tasks List")
                        .font(CustomFont.title.font)
                        .foregroundColor(CustomFont.title.color)
                        .frame(maxWidth: .infinity, alignment: .center)
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
