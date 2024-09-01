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
    
    @State private var draggedTaskCount: Int = 0
    
    var destinationView: some View {
        switch priority {
        case .importantButNotUrgent:
            return AnyView(ScheduleItView().environmentObject(taskManager))
        case .importantAndUrgent:
            return AnyView(DoItNowView().environmentObject(taskManager))
        case .notImportantNotUrgent:
                return AnyView(DoItLaterView(tasks: $tasks).environmentObject(taskManager))
        case .urgentButNotImportant:
            return AnyView(DelegateItView().environmentObject(taskManager))
        }
    }
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack(spacing: 8) {
                Text(priority.rawValue)
                    .font(.headline)
                    .foregroundColor(Color.white)
                
                Text(priority == .importantButNotUrgent ? "SCHEDULE IT" :
                        priority == .importantAndUrgent ? "DO IT NOW" :
                        priority == .notImportantNotUrgent ? "DO IT LATER" :
                        "DELEGATE IT")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .bold()
                
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(Color.white)
                        .frame(width: 32, height: 32)
                    
                    Text("\(draggedTaskCount)")
                        .foregroundColor(Color.green)
                        .font(.headline)
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
                                taskManager.moveTaskToPriorityList(task, priority: priority)
                                self.tasks = taskManager.getTasks(for: priority)
                                updateDraggedTaskCount()
                            }
                        }
                    }
                }
                return true
            }
            .onAppear {
                updateDraggedTaskCount()
            }
            .onChange(of: tasks) { _, _ in
                updateDraggedTaskCount()
            }
        }
    }
    
    private func updateDraggedTaskCount() {
        draggedTaskCount = taskManager.getTasks(for: priority).count
    }
}
