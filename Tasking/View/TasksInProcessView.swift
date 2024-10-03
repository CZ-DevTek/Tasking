//
//  TasksInProcessView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/10/24.
//

import SwiftUI

struct TasksInProcessView: View {
    @EnvironmentObject var taskManager: TaskManager
    @Binding var selectedTab: Int
    
    var body: some View {
        List(taskManager.sortedTasks) { task in
            NavigationLink(destination: taskManager.destinationView(for: task)) {
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
                    .font(.custom("Noteworthy-Bold", size: 34))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
    }
}
