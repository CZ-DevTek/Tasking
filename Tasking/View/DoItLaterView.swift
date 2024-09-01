//
//  DoItLaterView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DoItLaterView: View {
    @EnvironmentObject var taskManager: TaskManager
    @Binding var tasks: [Task]

    var body: some View {
        VStack {
            Text("DO IT LATER")
                .font(.largeTitle)
                .bold()
            List {
                ForEach(taskManager.doItLaterTasks) { task in
                                    Text(task.name)
                }
            }
        }
        .navigationTitle("DO IT LATER")
    }
}
