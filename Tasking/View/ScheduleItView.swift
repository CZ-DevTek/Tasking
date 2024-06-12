//
//  ScheduleItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct ScheduleItView: View {
    let tasks: [Task]

    var body: some View {
        VStack {
            Text("SCHEDULE IT")
                .font(.largeTitle)
                .bold()
            List {
                ForEach(tasks) { task in
                    Text(task.name)
                }
            }
        }
        .navigationTitle("SCHEDULE IT")
    }
}
