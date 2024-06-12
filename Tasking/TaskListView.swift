//
//  ContentView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI


struct TaskListView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Task 1")
                Text("Task 2")
                Text("Task 3")
            }
            .navigationTitle("Task List")
        }
    }
}

#Preview {
    TaskListView()
}
