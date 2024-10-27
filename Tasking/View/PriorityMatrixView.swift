//
//  PriorityView + PriorityButton.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PriorityMatrixView: View {
    let priority: Priority
    @Binding var tasks: [Task]
    @Binding var allTasks: [Task]
    let color: Color
    let taskManager: TaskManager
    @State private var draggedTaskCount: Int = 0
    
    var body: some View {
        NavigationLink(destination: taskManager.linkTo(for: priority)) {
            VStack(spacing: 4) {
                Text(priority == .importantAndUrgent ? "DO" :
                        priority == .importantButNotUrgent ? "SCHEDULE" :
                        priority == .urgentButNotImportant ? "DELEGATE" :
                        "DO IT LATER")
                .font(CustomFont.subtitle.font)
                .foregroundColor(CustomFont.subtitle.color)
                Text(priority.rawValue)
                    .font(CustomFont.footnote.font)
                    .foregroundColor(CustomFont.footnote.color)
                
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(Color.white)
                        .frame(width: 28, height: 28)
                    
                    Text("\(draggedTaskCount)")
                        .foregroundColor(Color.green)
                        .font(.headline)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(color)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
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
