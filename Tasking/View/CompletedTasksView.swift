//
//  TasksDoneTodayView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/9/24.

import SwiftUI

struct CompletedTasksView: View {
    @EnvironmentObject private var taskManager: TaskManager
    
    var body: some View {
        NavigationView {
            VStack {
                if taskManager.completedTasks.isEmpty {
                    Text("The list of completed tasks is clean.")
                        .foregroundColor(.white)
                        .padding()
                } else {
                    List {
                        ForEach(taskManager.completedTasks) { task in
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(task.name)
                                        .font(CustomFont.body.font)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                taskManager.removeCompletedTask(at: index)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                taskManager.clearCompletedTasks()
                            }
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                Text("Clear List")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.red)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.bottom)
                }
            }
            .customizeBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Completed Tasks")
                        .font(CustomFont.title.font)
                        .foregroundColor(CustomFont.title.color)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}


struct CompletedTasksView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTasksView()
            .environmentObject(TaskManager())
    }
}
