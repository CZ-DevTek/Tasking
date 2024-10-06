//
//  TasksDoneTodayView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/9/24.
//

import SwiftUI

struct CompletedTasksView: View {
    @EnvironmentObject private var taskManager: TaskManager
    
    var body: some View {
        NavigationView {
            VStack {
                if taskManager.completedTasks.isEmpty {
                    Text("The list of completed tasks is clean.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(taskManager.completedTasks) { task in
                            VStack(spacing: 0) {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(task.name)
                                        .font(CustomFont.body.font)
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 2)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.blue.opacity(0.4))
                                    .padding(.horizontal, 8)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                taskManager.removeCompletedTask(at: index)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.white)
                    }
                    .cornerRadius(20)
                    .padding(.top)
                    .scrollContentBackground(.hidden)
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                taskManager.clearCompletedTasks()
                            }
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                Text("Clear List")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .navigationTitle("")
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
