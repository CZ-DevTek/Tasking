//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }
            
            PriorityView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Priorities")
                }
        }
    }
}

#Preview {
    HomeView()
}

