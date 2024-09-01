//
//  ScheduleItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct ScheduleItView: View {
    @EnvironmentObject var taskManager: TaskManager

    var body: some View {
        VStack {
            Text("SCHEDULE")
                .font(.largeTitle)
                .bold()

            List {
                ForEach(taskManager.scheduleItTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            taskManager.shareTask(task)
                        }) {
                            Text("Schedule Task")
                            Image(systemName: "calendar.badge.checkmark")
                        }
                    }
                }
                .onDelete { indexSet in
                    taskManager.scheduleItTasks.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("SCHEDULE IT")
        }
    }
}

#Preview {
    ScheduleItView()
        .environmentObject(TaskManager())
}
