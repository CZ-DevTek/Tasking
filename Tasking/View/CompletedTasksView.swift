//
//  TasksDoneTodayView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/9/24.
//

import SwiftUI

struct CompletedTasksView: View {
    @EnvironmentObject var taskManager: TaskManager
    
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
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(task.name)
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    
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
                        .padding()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Completed Tasks")
                        .font(.custom("Noteworthy-Bold", size: 34))
                        .foregroundColor(.black)
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
