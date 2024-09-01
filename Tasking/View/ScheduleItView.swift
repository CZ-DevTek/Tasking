//
//  ScheduleItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import EventKit

struct ScheduleItView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var selectedTask: Task?
    @State private var showAlert = false

    var body: some View {
        VStack {
            Text("SCHEDULE")
                .font(.largeTitle)
                .bold()

            List {
                ForEach(Array(taskManager.scheduleItTasks.enumerated()), id: \.element.id) { index, task in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(task.name)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Button("Schedule Task") {
                                selectedTask = task
                                openCalendar(for: task)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("SCHEDULE IT")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Calendar Access Denied"), message: Text("Please allow calendar access in settings."), dismissButton: .default(Text("OK")))
        }
    }

    private func openCalendar(for task: Task) {
        let eventStore = EKEventStore()
        
        // Handle permission request
        eventStore.requestFullAccessToEvents { granted, error in
            DispatchQueue.main.async {
                if granted {
                    createEvent(for: task, in: eventStore)
                } else {
                    showAlert = true
                }
            }
        }
    }

    private func createEvent(for task: Task, in eventStore: EKEventStore) {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate) ?? startDate
        
        let event = EKEvent(eventStore: eventStore)
        event.title = task.name
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: "calshow:\(startDate.timeIntervalSince1970)")!)
            }
        } catch {
            print("Error saving event: \(error)")
        }
    }
}

#Preview {
    ScheduleItView()
        .environmentObject(TaskManager())
}
