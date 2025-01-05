//
//  PieChartView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 5/1/25.

import SwiftUI

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

struct PieChartSection: View {
    let taskManager: TaskManager

    var body: some View {
        PieChartView(
            data: [
                Double(taskManager.completedDoTasks.count),
                Double(taskManager.completedScheduleTasks.count),
                Double(taskManager.completedDelegateTasks.count)
            ],
            colors: [.customGreen, .customYellow, .customBlue],
            labels: ["Do It Now", "Schedule It", "Delegate It"]
        )
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

