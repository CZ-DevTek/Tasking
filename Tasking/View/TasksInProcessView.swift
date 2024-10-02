//
//  TasksInProcessView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/10/24.
//

import SwiftUI

struct TasksInProcessView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        NavigationView {
            List(taskManager.sortedTasks) { task in
                NavigationLink(destination: destinationView(for: task)) {
                    HStack(alignment: .center) {
                        Text(task.name)
                            .foregroundColor(.white)
                            .padding(12)
                            .padding(.vertical, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(taskManager.color(for: task))
                    .cornerRadius(8)
                    .onTapGesture {
                        taskManager.handleTaskTap(task: task)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("")
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
            }
        }
    }
}

