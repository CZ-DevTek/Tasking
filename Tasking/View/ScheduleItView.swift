//
//  ScheduleItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct ScheduleItView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var selectedTask: Task?
    @State private var showPriorityAlert = false
    
    var body: some View {
        VStack {
            List {
                ForEach(taskManager.scheduleItTasks) { task in
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
                            Text("Schedule it in calendar")
                            Image(systemName: "calendar")
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
                            .fill(Color.white)
                            .padding(2)
                    )
                }
                .onDelete { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            let task = taskManager.scheduleItTasks[index]
                            taskManager.moveTaskToTaskList(task, from: $taskManager.scheduleItTasks)
                            
                        }
                    }
                }
            }
            
            .scrollContentBackground(.hidden)
            .background(.yellow.opacity(0.3))
            .cornerRadius(20)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Schedule It")
                        .font(.custom("Noteworthy Bold", size: 34))
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .alert(isPresented: $showPriorityAlert) {
                Alert(
                    title: Text("Move Task"),
                    message: Text("Do you want to move this task back to the Task List?"),
                    primaryButton: .default(Text("Move")) {
                        if let task = selectedTask {
                            taskManager.moveTaskToTaskList(task, from: $taskManager.scheduleItTasks)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .background(.yellow.opacity(0.2))
    }
    
}

#Preview {
    ScheduleItView()
        .environmentObject(TaskManager())
}
