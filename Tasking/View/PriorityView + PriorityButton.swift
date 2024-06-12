//
//  PriorityView + PriorityButton.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PriorityButton: View {
    let priority: Priority
    @Binding var tasks: [Task]
    @Binding var allTasks: [Task]
    let color: Color
    let taskManager: TaskManager
    
    init(priority: Priority, tasks: Binding<[Task]>, allTasks: Binding<[Task]>, color: Color, taskManager: TaskManager) {
        self.priority = priority
        self._tasks = tasks
        self._allTasks = allTasks
        self.color = color
        self.taskManager = taskManager
    }
    var destinationView: some View {
        switch priority {
            case .importantButNotUrgent:
                return AnyView(ScheduleItView(tasks: tasks))
            case .importantAndUrgent:
                return AnyView(DoItNowView(tasks: tasks))
            case .notImportantNotUrgent:
                return AnyView(DoItLaterView(tasks: tasks))
            case .urgentButNotImportant:
                return AnyView(DelegateItView(tasks: tasks))
        }
    }
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack {
                Text(priority.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(priority == .importantButNotUrgent ? "SCHEDULE IT" :
                        priority == .importantAndUrgent ? "DO IT NOW" :
                        priority == .notImportantNotUrgent ? "DO IT LATER" :
                        "DELEGATE IT")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
                
                ForEach(tasks, id: \.self) { task in
                    Text(task.name)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .cornerRadius(10)
            .padding(4)
            .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                guard let item = providers.first else { return false }
                item.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (data, error) in
                    if let data = data as? Data, let string = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            if let taskIndex = allTasks.firstIndex(where: { $0.name == string }) {
                                let task = allTasks.remove(at: taskIndex)
                                tasks.append(task)
                                taskManager.saveTasks()
                            }
                        }
                    }
                }
                return true
            }
        }
    }
}
