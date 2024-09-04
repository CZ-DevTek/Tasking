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
            Text("DELEGATE")
                .font(.largeTitle)
                .bold()
            
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
            .navigationTitle("DELEGATE IT")
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
    }
}

#Preview {
    DelegateItView()
        .environmentObject(TaskManager())
}
