//
//  DelegateItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DelegateItView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var selectedTask: Task?
    @State private var showPriorityAlert = false
    
    var body: some View {
        VStack {
            List {
                ForEach(taskManager.delegateItTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            taskManager.shareTask(task)
                            taskManager.moveTaskToCompleted(task)
                        }) {
                            Text("Ask to")
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                        Button(action: {
                            selectedTask = task
                            showPriorityAlert = true
                        }) {
                            Text("Move to Task List")
                            Image(systemName: "arrow.left.circle")
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                                Capsule()
                                    .fill(.white)
                                    .padding(2)
                                )
                }
                .onDelete { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            let task = taskManager.delegateItTasks[index]
                            taskManager.moveTaskToTaskList(task, from: $taskManager.delegateItTasks)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.blue.opacity(0.3))
            .cornerRadius(20)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Delegate It")
                        .font(.custom("Noteworthy Bold", size: 34))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .alert(isPresented: $showPriorityAlert) {
                Alert(
                    title: Text("Move Task"),
                    message: Text("Do you want to move this task back to the Task List?"),
                    primaryButton: .default(Text("Move")) {
                        if let task = selectedTask {
                            taskManager.moveTaskToTaskList(task, from: $taskManager.delegateItTasks)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .background(.blue.opacity(0.2))
    }
}

#Preview {
    DelegateItView()
        .environmentObject(TaskManager())
}
