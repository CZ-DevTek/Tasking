//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var taskManager = TaskManager()
    @State var isShowingInfo = false

    var body: some View {
        NavigationView {
            TabView {
                TaskListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Tasks")
                    }
                    .environmentObject(taskManager)
                
                PriorityView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Priorities")
                    }
                    .environmentObject(taskManager)
                    
                CompletedTasksView()
                    .tabItem {
                        Image(systemName: "checkmark.circle")
                        Text("Completed")
                    }
                    .environmentObject(taskManager)
            }
            .navigationTitle("Task Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingInfo.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingInfo) {
                InfoView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

