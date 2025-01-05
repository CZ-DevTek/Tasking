//
//  StatisticsView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.

import SwiftUI
import Charts

struct StatisticsView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @EnvironmentObject private var statisticsManager: StatisticsManager
    @Environment(\.presentationMode) var presentationMode
    @State private var updateCounter: Int = 0
    let priority: Priority
    @State private var selectedTimeFrame: TimeFrame = .week

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .customizeMenuBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HeaderSection(taskManager: taskManager)
                        Divider()

                        PieChartSection(taskManager: taskManager)
                            .frame(height: 200)
                            .padding(.vertical)

                        Divider()

                        StatisticsSection(taskManager: taskManager)
                            .padding(.vertical)
                    }
                    VStack {
                                Picker("Time Frame", selection: $selectedTimeFrame) {
                                    Text("Week").tag(TimeFrame.week)
                                    Text("Month").tag(TimeFrame.month)
                                    Text("Year").tag(TimeFrame.year)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                                
                                BarChartView(timeFrame: selectedTimeFrame)
                                    .environmentObject(statisticsManager)
                            }
                    .padding()
                }
            }
            .navigationBarTitle(
                Text(NSLocalizedString("Statistics", comment: "Statistics")),
                displayMode: .inline
            )
            .navigationBarItems(leading: GoBackButton(presentationMode: presentationMode))
        }
    }
}

struct HeaderSection: View {
    let taskManager: TaskManager

    var body: some View {
        HStack {
            Text(NSLocalizedString("Completed Tasks", comment: "Completed Tasks"))
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}

struct StatisticsSection: View {
    let taskManager: TaskManager

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            StatisticRow(title: NSLocalizedString("Total Completed Tasks", comment: "Total Completed Tasks"), count: taskManager.allCompletedTasks.count)
            StatisticRow(title: NSLocalizedString("Do It Now", comment: "Do It Now"), count: taskManager.completedDoTasks.count)
            StatisticRow(title: NSLocalizedString("Schedule It", comment: "Schedule It"), count: taskManager.completedScheduleTasks.count)
            StatisticRow(title: NSLocalizedString("Delegate It", comment: "Delegate It"), count: taskManager.completedDelegateTasks.count)
        }
    }
}


struct GoBackButton: View {
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .font(.headline)
                .foregroundColor(.white)
        }
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
