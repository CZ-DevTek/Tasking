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
    @State private var isNavigating = false
    
    var body: some View {
        NavigationStack {
            List(taskManager.sortedTasks) { task in
                Button(action: {
                    selectedTask = task
                    isNavigating = true
                    taskManager.handleTaskTap(task: task, selectedTab: $selectedTab)  // Switch tab
                }) {
                    HStack(alignment: .center) {
                        Text(task.name)
                            .foregroundColor(.white)
                            .padding(12)
                            .padding(.vertical, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(taskManager.color(for: task))
                    .cornerRadius(8)
                }
                .listRowInsets(EdgeInsets())
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Tasks In Process")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Tasks In Process")
                        .font(.custom("Noteworthy-Bold", size: 34))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .navigationDestination(isPresented: $isNavigating) {
                if let task = selectedTask {
                    taskManager.destinationView(for: task)
                }
            }
        }
    }
}
