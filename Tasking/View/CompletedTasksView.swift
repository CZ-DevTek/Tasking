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
                        .onDelete { indexSet in
                            for index in indexSet {
                                taskManager.removeCompletedTask(at: index)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                                    Capsule()
                                        .fill(.white)
                                        .padding(2)
                                )
                    }
                    .cornerRadius(20)
                    .padding(.top)
                   
                    
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
            .cornerRadius(20)
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
