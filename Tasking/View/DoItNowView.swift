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
                ForEach(taskManager.tasks) { task in
                    SwipeToDeleteRow(task: task) {
                        taskManager.completeTask(for: task)
                    }
                }
                .onDelete { indexSet in
                    taskManager.tasks.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("DO IT NOW")
        }
        .padding()
    }
}
struct SwipeToDeleteRow: View {
    let task: Task
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.completed ? .green : .gray)
                    .font(.title)
            }
            .padding(.trailing, 8)
            
            Text(task.name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle()) // Ensure the whole row is tappable
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
