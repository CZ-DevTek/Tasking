//
//  DelegateItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DelegateItView: View {
    @EnvironmentObject var taskManager: TaskManager
    @Binding var tasks: [Task]

    var body: some View {
        VStack {
            Text("DELEGATE IT")
                .font(.largeTitle)
                .bold()
            List {
                ForEach(taskManager.delegateItTasks) { task in
                                    Text(task.name)
                }
            }
        }
        .navigationTitle("DELEGATE IT")
    }
}
