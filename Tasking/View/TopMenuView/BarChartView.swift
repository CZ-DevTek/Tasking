//
//  BarChartView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 5/1/25.
//

import SwiftUI
import Charts

struct BarChartView: View {
    @StateObject var statisticsManager = StatisticsManager()
    let timeFrame: TimeFrame

    var body: some View {
        let completionData = statisticsManager.getCompletionData(for: timeFrame)
        let dateLabels = statisticsManager.generateDateLabels(for: timeFrame)
        
        Chart {
            ForEach(0..<completionData.count, id: \.self) { index in
                let data = completionData[index]
                BarMark(
                    x: .value("Day", index),
                    y: .value("Do It Now", data[0])
                )
                .foregroundStyle(Color.customGreen)
                
                BarMark(
                    x: .value("Day", index),
                    y: .value("Schedule It", data[1])
                )
                .foregroundStyle(Color.customYellow)
                
                BarMark(
                    x: .value("Day", index),
                    y: .value("Delegate It", data[2])
                )
                .foregroundStyle(Color.customBlue)
            }
        }
        .chartXAxis {
            AxisMarks(values: xAxisValues(for: timeFrame)) { value in
                AxisValueLabel {
                    Text(dateLabels[value.as(Int.self) ?? 0])
                        .foregroundColor(.white)
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: [0, 25, 50, 75, 100]) { value in
                AxisGridLine()
                AxisValueLabel {
                    Text("\(value.as(Int.self) ?? 0)")
                        .foregroundColor(.white)
                }
            }
        }
        .chartYScale(domain: 0...100) 
        .frame(height: 150)
        .padding()
    }
    
    private func xAxisValues(for timeFrame: TimeFrame) -> [Int] {
        let count = statisticsManager.getCompletionData(for: timeFrame).count
        switch timeFrame {
        case .week:
            return Array(max(count - 7, 0)..<count)
        case .month:
            return stride(from: 0, to: count, by: count / 2).map { $0 }
        case .year:
            return stride(from: 0, to: count, by: count / 12).map { $0 }
        }
    }
}

enum TimeFrame {
    case week
    case month
    case year
}

