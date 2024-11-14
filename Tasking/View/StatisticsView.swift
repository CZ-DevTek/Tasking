//
//  StadisticsView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.
//

import SwiftUI

struct StatisticsView: View {
    @State private var completedTaskCount: Int = 0
    @EnvironmentObject private var taskManager: TaskManager
    let priority: Priority
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Statistics")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 5)
            
            Text("Completed Tasks by Priority")
                .font(.title2)
                .foregroundColor(.gray)
            
            Divider()
            
            VStack {
                Text("Completed Tasks: \(taskManager.completedTasks.count)")
                Text("Do It Now: \(taskManager.completedTasks.filter { $0.priority == .importantAndUrgent }.count)")
                Text("Schedule It: \(taskManager.completedTasks.filter { $0.priority == .importantButNotUrgent }.count)")
                Text("Delegate It: \(taskManager.completedTasks.filter { $0.priority == .urgentButNotImportant }.count)")
            }
            .padding(.vertical)
        }
        .onChange(of: priority) { _, _ in
            updateCompletedTaskCount()
        }
    }
    struct StatisticRow: View {
        let title: String
        let count: Int
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text("\(count)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
    }
    private func updateCompletedTaskCount() {
        completedTaskCount = taskManager.getCompletedTasks(for: priority).count
    }
}

