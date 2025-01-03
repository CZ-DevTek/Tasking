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
                                taskManager.markTaskAsCompleted(for: task)
                                taskManager.moveTaskToCompleted(task)
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            taskManager.shareTask(task)
                        }) {
                            Text(NSLocalizedString("Schedule it in calendar", comment: "Schedule it in calendar"))
                            Image(systemName: "calendar")
                        }
                        Button(action: {
                            selectedTask = task
                            showPriorityAlert = true
                        }) {
                            Text(NSLocalizedString("Move to Task List", comment: "Move to Task List" ))
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
                            taskManager.removeTaskFromCurrentList(task)
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
                    Text(NSLocalizedString("Schedule It", comment: "Schedule It"))
                        .font(CustomFont.title.font)
                        .foregroundColor(.customYellow)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .alert(isPresented: $showPriorityAlert) {
                Alert(
                    title: Text(NSLocalizedString("Move Task", comment: "Move Task")),
                    message: Text(NSLocalizedString("Do you want to move this task back to the Task List?", comment: "Do you want to move this task back to the Task List?")),
                    primaryButton: .default(Text(NSLocalizedString("Move", comment: "Move"))) {
                        if let task = selectedTask {
                            taskManager.moveTaskToTaskList(task, from: $taskManager.scheduleItTasks)
                        }
                    },
                    secondaryButton: .cancel(Text(NSLocalizedString("Cancel", comment: "Cancel")))
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
