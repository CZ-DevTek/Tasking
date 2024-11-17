//
//  StadisticsView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var updateCounter: Int = 0
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

                VStack(alignment: .leading, spacing: 10) {
                    StatisticRow(title: "Total Completed Tasks", count: taskManager.allCompletedTasks.count)
                    StatisticRow(title: "Do It Now", count: taskManager.completedDoTasks.count)
                    StatisticRow(title: "Schedule It", count: taskManager.completedScheduleTasks.count)
                    StatisticRow(title: "Delegate It", count: taskManager.completedDelegateTasks.count)
                }
                .padding(.vertical)

                Button("Force Update") {
                    updateCounter += 1
                }
            }
            .padding()
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
