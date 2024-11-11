//
//  ScheduleItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct ScheduleItView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var selectedTask: Task?
    @State private var showPriorityAlert = false
    @State private var showScheduledConfirmation = false
    @State private var taskToConfirm: Task?
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = true

    var body: some View {
        VStack {
            List {
                ForEach(taskManager.scheduleItTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(CustomFont.body.font)
                            .foregroundColor(.customYellow)
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            taskManager.shareTask(task)
                            taskToConfirm = task
                            
                            
                            showScheduledConfirmation = true
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
                        Rectangle()
                            .fill(.yellow)
                            .padding(2)
                            .cornerRadius(15)
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
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(.clear)
            .cornerRadius(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Schedule It")
                        .font(CustomFont.title.font)
                        .foregroundColor(.customYellow)
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
            .alert(isPresented: $showScheduledConfirmation) {
                Alert(
                    title: Text("Task Scheduled?"),
                    message: Text("Was this task successfully scheduled in your calendar?"),
                    primaryButton: .default(Text("✅ Yes")) {
                        if let task = taskToConfirm {
                            taskManager.moveTaskToCompleted(task)
                        }
                    },
                    secondaryButton: .destructive(Text("❌ No")) {
                        taskToConfirm = nil
                    }
                )
            }
            FoldingButtonBar(isExpanded: $isExpanded)
                .padding(.bottom, 8)
        }
        .padding()
        .customizeSubviewsBackground(for: .yellow)
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


#Preview {
    ScheduleItView()
        .environmentObject(TaskManager())
}
