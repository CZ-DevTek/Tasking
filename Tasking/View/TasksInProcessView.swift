//
//  TasksInProcessView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/10/24.
//

import SwiftUI

struct TasksInProcessView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var selectedTab: Int
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationStack {
            List(taskManager.sortedTasks) { task in
                VStack(spacing: 0) {
                    HStack {
                        NavigationLink(destination: taskManager.destinationView(for: task)) {
                            HStack(alignment: .center) {
                                Text(task.name)
                                    .font(CustomFont.body.font)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadius(8)
                        }
                        .background(taskManager.color(for: task).opacity(0.85))
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.blue.opacity(0.4))
                        .padding(.horizontal, 8)
                }
                .padding(.vertical, 3)
                .listRowInsets(EdgeInsets())
                .background(Color.clear)
                .onAppear {
                    selectedTab = 2
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Tasks In Process")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Tasks In Process")
                        .font(CustomFont.title.font)
                        .foregroundColor(CustomFont.title.color)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding()
        }
    }
}

