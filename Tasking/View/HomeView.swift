//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
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
        }
    }
}

#Preview {
    HomeView()
}

