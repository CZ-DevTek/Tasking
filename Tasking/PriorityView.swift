//
//  PriorityView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let name: String
}

struct PriorityView: View {
    @State private var tasks: [Task] = [
        Task(name: "Task 1"),
        Task(name: "Task 2"),
        Task(name: "Task 3"),
        Task(name: "Task 4")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Upper half: Task list
            List {
                ForEach(tasks) { task in
                    Text(task.name)
                        .onDrag {
                            NSItemProvider(object: task.name as NSString)
                        }
                }
            }
            .frame(maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            
            // Lower half: Priority matrix
            VStack {
                HStack {
                    PriorityButton(title: "Important\nbut not urgent")
                    PriorityButton(title: "Important\nand urgent")
                }
                HStack {
                    PriorityButton(title: "Not important\nand not urgent")
                    PriorityButton(title: "Not important\nand urgent")
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    PriorityView()
}
