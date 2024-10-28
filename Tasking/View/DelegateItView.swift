//
//  DelegateItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct DelegateItView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var selectedTask: Task?
    @State private var showPriorityAlert = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = true
    
    
    var body: some View {
        VStack {
            List {
                ForEach(taskManager.delegateItTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(CustomFont.body.font)
                            .foregroundColor(Color.gray)
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
            .background(.clear)
            .cornerRadius(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Delegate It")
                        .font(CustomFont.title.font)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 8)
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
            FoldingButtonBar(isExpanded: $isExpanded)
                .padding(.bottom, 8)
        }
        .padding()
        .customizeSubviewsBackground(for: .blue)
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    DelegateItView()
        .environmentObject(TaskManager())
}
