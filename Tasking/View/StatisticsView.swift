//
//  StadisticsView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var taskManager: TaskManager

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
                StatisticRow(title: "Do It Now Tasks", count: taskManager.totalCompletedTaskCount(for: .importantAndUrgent))
                StatisticRow(title: "Scheduled Tasks", count: taskManager.totalCompletedTaskCount(for: .importantButNotUrgent))
                StatisticRow(title: "Delegated Tasks", count: taskManager.totalCompletedTaskCount(for: .urgentButNotImportant))
            }
            .padding(.vertical)

            Divider()

            Text("Task Completion Overview")
                .font(.title2)
                .foregroundColor(.gray)

            TaskCompletionBarChart(data: taskCompletionData())
                .frame(height: 200)
        }
        .padding()
    }

    private func taskCompletionData() -> [TaskCompletionData] {
        [
            TaskCompletionData(priority: "Do It Now", count: taskManager.totalCompletedTaskCount(for: .importantAndUrgent)),
            TaskCompletionData(priority: "Schedule It", count: taskManager.totalCompletedTaskCount(for: .importantButNotUrgent)),
            TaskCompletionData(priority: "Delegate It", count: taskManager.totalCompletedTaskCount(for: .urgentButNotImportant))
        ]
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

struct TaskCompletionBarChart: View {
    let data: [TaskCompletionData]

    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            ForEach(data, id: \.priority) { item in
                VStack {
                    Text("\(item.count)")
                        .font(.footnote)
                        .padding(.bottom, 5)

                    Rectangle()
                        .fill(gradient(for: item.priority))
                        .frame(width: 30, height: CGFloat(item.count) * 10)

                    Text(item.priority)
                        .font(.footnote)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.top, 5)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func gradient(for priority: String) -> LinearGradient {
        switch priority {
        case "Do It Now":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.cyan]), startPoint: .top, endPoint: .bottom)
        case "Schedule It":
            return LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .top, endPoint: .bottom)
        case "Delegate It":
            return LinearGradient(gradient: Gradient(colors: [Color.red, Color.pink]), startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
        }
    }
}

struct TaskCompletionData {
    let priority: String
    let count: Int
}
