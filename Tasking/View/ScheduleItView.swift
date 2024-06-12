//
//  ScheduleItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import UserNotifications

struct ScheduleItView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var selectedTask: Task?
    @State private var showDatePicker = false
    @State private var dueDate = Date()

    var body: some View {
        VStack {
            Text("SCHEDULE IT")
                .font(.largeTitle)
                .bold()

            List {
                ForEach(taskManager.tasks.indices, id: \.self) { index in
                    let task = taskManager.tasks[index]
                    VStack(alignment: .leading) {
                        HStack {
                            Text(task.name)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if let dueDate = task.dueDate {
                                Text(dateFormatter.string(from: dueDate))
                            } else {
                                Button("Set Date") {
                                    selectedTask = task
                                    showDatePicker.toggle()
                                }
                            }
                        }

                        if task.dueDate != nil {
                            HStack {
                                Spacer()
                                Button(action: {
                                    toggleNotification(for: index)
                                }) {
                                    Image(systemName: "envelope")
                                        .foregroundColor(task.hasNotification ? .green : .primary)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker("Select Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                Button("Confirm Date") {
                    if let task = selectedTask {
                        taskManager.updateTaskDueDate(task, newDate: dueDate)
                        showDatePicker = false
                    }
                }
                .padding()
            }
        }
        .navigationTitle("SCHEDULE IT")
    }

    func toggleNotification(for index: Int) {
        guard let task = taskManager.tasks[safe: index] else { return }

        taskManager.tasks[index].toggleNotification()
        if taskManager.tasks[index].hasNotification {
            scheduleNotification(for: task)
        } else {
            // Remove notification if needed
            // Code to remove notification goes here
        }
        taskManager.saveTasks()
    }

    func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = task.name
        content.sound = UNNotificationSound.default

        if let dueDate = task.dueDate {
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    DispatchQueue.main.async {
                        showAlert(title: "Notification Set", message: "Notification was set successfully on \(dateFormatter.string(from: dueDate)).")
                    }
                }
            }
        }
    }

    func showAlert(title: String, message: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
