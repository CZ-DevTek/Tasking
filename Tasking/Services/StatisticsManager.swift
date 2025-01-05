//
//  StatisticsManager.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 5/1/25.

import SwiftUI

class StatisticsManager: ObservableObject {
    @Published private var tasks: [Task] = []

    func getCompletionData(for timeFrame: TimeFrame) -> [[Double]] {
        switch timeFrame {
        case .week:
            return getWeeklyCompletionData()
        case .month:
            return getMonthlyCompletionData()
        case .year:
            return getYearlyCompletionData()
        }
    }

    private func getWeeklyCompletionData() -> [[Double]] {
        return getCompletionData(forDays: 7)
    }

    private func getMonthlyCompletionData() -> [[Double]] {
        return getCompletionData(forDays: 30)
    }

    private func getYearlyCompletionData() -> [[Double]] {
        return getCompletionData(forDays: 365, groupBy: .weekOfYear)
    }

    private func getCompletionData(forDays days: Int, groupBy component: Calendar.Component = .day) -> [[Double]] {
        var completionData = Array(repeating: [Double](repeating: 0, count: 3), count: days)
        
        let calendar = Calendar.current
        let today = Date()

        for dayOffset in 0..<days {
            if let dayDate = calendar.date(byAdding: .day, value: -dayOffset, to: today) {
                let startDate = calendar.startOfDay(for: dayDate)
                let endDate = calendar.date(byAdding: component, value: 1, to: startDate)!

                let completedTasks = tasks.filter { task in
                    guard let completionDate = task.completionDate else { return false }
                    return completionDate >= startDate && completionDate < endDate
                }
                
                if completedTasks.isEmpty {
                    continue
                }

                let doItNowCount = completedTasks.filter { $0.priority == .importantAndUrgent }.count
                let scheduleItCount = completedTasks.filter { $0.priority == .importantButNotUrgent }.count
                let delegateItCount = completedTasks.filter { $0.priority == .urgentButNotImportant }.count

                completionData[dayOffset] = [
                    Double(doItNowCount) / Double(completedTasks.count) * 100,
                    Double(scheduleItCount) / Double(completedTasks.count) * 100,
                    Double(delegateItCount) / Double(completedTasks.count) * 100
                ]
            }
        }

        return completionData
    }

    func calculateAverage(for timeFrame: TimeFrame) -> [Double] {
            let completionData = getCompletionData(for: timeFrame)
            let days = completionData.count

            var sumDoItNow = 0.0
            var sumScheduleIt = 0.0
            var sumDelegateIt = 0.0

            for dailyData in completionData {
                sumDoItNow += dailyData[0]
                sumScheduleIt += dailyData[1]
                sumDelegateIt += dailyData[2]
            }

            return [
                sumDoItNow / Double(days),
                sumScheduleIt / Double(days),
                sumDelegateIt / Double(days)
            ]
        }

    func generateDateLabels(for timeFrame: TimeFrame) -> [String] {
        let days = daysCountForTimeFrame(timeFrame)
        let calendar = Calendar.current
        let endDate = Date()
        let dateFormatter = DateFormatter()
        
        switch timeFrame {
        case .week:
            dateFormatter.dateFormat = "MMM dd"
        case .month:
            dateFormatter.dateFormat = "M"
        case .year:
            dateFormatter.dateFormat = "M"
        }

        return (0..<days).map { i in
            let date = calendar.date(byAdding: .day, value: -i, to: endDate)!
            return dateFormatter.string(from: date)
        }.reversed()
    }

    private func daysCountForTimeFrame(_ timeFrame: TimeFrame) -> Int {
        switch timeFrame {
        case .week: return 7
        case .month: return 30
        case .year: return 365
        }
    }
}
