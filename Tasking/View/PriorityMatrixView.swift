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
    @ObservedObject var taskManager: TaskManager
    @State private var draggedTaskCount: Int = 0
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging: Bool = false
    @State private var isTargeted: Bool = false

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
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)

                    Text("\(draggedTaskCount)")
                        .foregroundColor(.green)
                        .font(.headline)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(isTargeted ? .gray.opacity(0.2) : color)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            .cornerRadius(10)
            .padding(4)
            .onDrop(of: [UTType.text], isTargeted: $isTargeted) { providers in
                handleTaskDrop(providers: providers)
                return true
            }
            .onAppear {
                updateDraggedTaskCount()
            }
            .onChange(of: tasks) { _, _ in
                updateDraggedTaskCount()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                        isDragging = true
                    }
                    .onEnded { _ in
                        dragOffset = .zero
                        isDragging = false
                    }
            )
            .overlay(
                Group {
                    if isDragging {
                        Circle()
                            .stroke(.blue, lineWidth: 2)
                            .frame(width: 50, height: 50)
                            .position(x: dragOffset.width + 50, y: dragOffset.height + 50)
                            .animation(.easeInOut(duration: 0.2), value: dragOffset)
                    }
                }
            )
        }
        .animation(.easeInOut, value: isTargeted)
    }

    private func handleTaskDrop(providers: [NSItemProvider]) {
        guard let item = providers.first else { return }

        item.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (data, error) in
            if let data = data as? Data, let taskName = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    if let taskIndex = allTasks.firstIndex(where: { $0.name == taskName }) {
                        let task = allTasks.remove(at: taskIndex)
                        taskManager.moveTaskToPriorityList(task, priority: priority)
                        self.tasks = taskManager.getTasks(for: priority)
                        updateDraggedTaskCount()
                    }
                }
            }
        }
    }

    private func updateDraggedTaskCount() {
        draggedTaskCount = taskManager.getTasks(for: priority).count
    }
}
