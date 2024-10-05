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
                NavigationLink(destination: taskManager.destinationView(for: task)) {
                    HStack(alignment: .center) {
                        Text(task.name)
                            .font(CustomFont.body.font)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.vertical, 3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(taskManager.color(for: task))
                    .cornerRadius(8)
                    .padding(.vertical, 3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray.opacity(0.2))
                .contentShape(Rectangle())
                .listRowInsets(EdgeInsets())
                .onAppear {
                    selectedTab = 2
                    
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
            }
            
            .scrollContentBackground(.hidden)
            .background(.gray.opacity(0.2))
            .cornerRadius(20)
            .padding()
        }
    }
}
