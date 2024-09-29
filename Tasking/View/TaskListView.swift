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
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Capsule()
                                .fill(.white)
                                .padding(2)
                        )
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            taskManager.removeTask(at: index)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.gray.opacity(0.2))
                .cornerRadius(20)
                .padding()
                
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
                    Text("After you write the tasks, take  some minutes to establish priorities")
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
                        .font(.custom("Noteworthy Bold", size: 34))
                        .foregroundColor(.black)
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
