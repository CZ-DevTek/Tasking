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
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = true
    
    var body: some View {
        VStack {
            List {
                ForEach(taskManager.scheduleItTasks) { task in
                    HStack {
                        TapToCompleteTask(
                            task: task,
                            color: .customYellow,
                            font: CustomFont.body.font
                        ){
                            withAnimation {
                                taskManager.completeTask(for: task)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    taskManager.moveTaskToCompleted(task)
                                }
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            taskManager.shareTask(task)
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
