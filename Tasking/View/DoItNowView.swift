//
//  DoItNowView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DoItNowView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        VStack {
            Text("DO IT NOW")
                .font(.largeTitle)
                .bold()
            
            List {
                ForEach(taskManager.doItNowTasks) { task in
                    SwipeToDeleteRow(task: task) {
                        withAnimation {
                            taskManager.completeTask(for: task)
                            if let index = taskManager.doItNowTasks.firstIndex(where: { $0.id == task.id }) {
                                taskManager.doItNowTasks.remove(at: index)
                                // Add task to TaskDoneToday
                                taskManager.addCompletedTask(task)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            let task = taskManager.doItNowTasks[index]
                            taskManager.completeTask(for: task)
                            taskManager.doItNowTasks.remove(at: index)
                            taskManager.addCompletedTask(task)
                        }
                    }
                }
            }
            .navigationTitle("DO IT NOW")
        }
        .padding()
    }
}
struct SwipeToDeleteRow: View {
    @State private var isCompleted: Bool = false
    let task: Task
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isCompleted.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        action()
                    }
                }
            }) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .green : .gray)
                    .font(.title)
            }
            .padding(.trailing, 8)
            
            Text(task.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(isCompleted ? 0.5 : 1)
        }
        .contentShape(Rectangle())
    }
}
    struct DoItNowView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                DoItNowView()
                    .environmentObject(TaskManager())
            }
        }
    }
