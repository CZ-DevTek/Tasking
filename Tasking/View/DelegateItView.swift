//
//  DelegateItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DelegateItView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        VStack {
            Text("DELEGATE IT")
                .font(.largeTitle)
                .bold()
            
            List {
                ForEach(taskManager.delegateItTasks) { task in
                    HStack {
                        Text(task.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            taskManager.moveTaskToDoItNow(task)
                        }) {
                            Text("Move to DoItNow")
                            Image(systemName: "arrow.right.circle")
                        }
                        
                        Button(action: {
                            taskManager.shareTask(task)
                        }) {
                            Text("Ask to")
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
                .onDelete { indexSet in
                    taskManager.delegateItTasks.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("DELEGATE IT")
        }
        .padding()
    }
}

#Preview {
    DelegateItView()
        .environmentObject(TaskManager())
}

