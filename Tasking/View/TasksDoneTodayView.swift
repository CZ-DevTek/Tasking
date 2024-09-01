//
//  TasksDoneTodayView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/9/24.
//

import SwiftUI

struct TaskDoneTodayView: View {
    @EnvironmentObject var taskManager: TaskManager

    var body: some View {
        VStack {
            HStack {
                Text("Completed Tasks")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button(action: {
                    withAnimation {
                        taskManager.clearCompletedTasks()
                    }
                }) {
                    Text("Clear")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .padding()

            if taskManager.completedTasks.isEmpty {
                Text("There are not completed tasks.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(taskManager.completedTasks) { task in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text(task.name)
                        }
                    }
                }
            }
        }
        .navigationTitle("Completed Tasks")
        .padding()
    }
}

struct TaskDoneTodayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskDoneTodayView()
                .environmentObject(TaskManager())
        }
    }
}

