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

            Text("Completed Tasks")
                .font(.title2)
                .foregroundColor(.gray)

            Divider()

            PieChartView(
                data: [
                    Double(taskManager.completedDoTasks.count),
                    Double(taskManager.completedScheduleTasks.count),
                    Double(taskManager.completedDelegateTasks.count)
                ],
                colors: [.customGreen, .customYellow, .customBlue],
                labels: ["Do It Now", "Schedule It", "Delegate It"]
            )
            .frame(height: 300)
            .padding(.vertical)

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                StatisticRow(title: "Total Completed Tasks", count: taskManager.allCompletedTasks.count)
                StatisticRow(title: "Do It Now", count: taskManager.completedDoTasks.count)
                StatisticRow(title: "Schedule It", count: taskManager.completedScheduleTasks.count)
                StatisticRow(title: "Delegate It", count: taskManager.completedDelegateTasks.count)
            }
            .padding(.vertical)
            .padding(.top)
        }
        .padding()
        .modifier(MenuBackgroundModifier())
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

struct PieChartView: View {
    let data: [Double]
    let colors: [Color]
    let labels: [String]

    var body: some View {
        GeometryReader { geometry in
            let total = data.reduce(0, +)
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                ForEach(data.indices, id: \.self) { index in
                    PieSliceView(
                        startAngle: angle(for: index, in: data, total: total),
                        endAngle: angle(for: index + 1, in: data, total: total),
                        color: colors[index]
                    )
                }

                VStack {
                    Text("Completed Tasks")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(Int(total))")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .position(center)
            }
        }
    }

    private func angle(for index: Int, in data: [Double], total: Double) -> Angle {
        let sum = data.prefix(index).reduce(0, +)
        return Angle(degrees: sum / total * 360)
    }
}

struct PieSliceView: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: min(geometry.size.width, geometry.size.height) / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false
                )
            }
            .fill(color)
        }
    }
}
