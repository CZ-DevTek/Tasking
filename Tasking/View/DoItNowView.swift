//
//  DoItNowView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DoItNowView: View {
    let tasks: [Task]

    var body: some View {
        VStack {
            Text("DO IT NOW")
                .font(.largeTitle)
                .bold()
            List {
                ForEach(tasks) { task in
                    Text(task.name)
                }
            }
        }
        .navigationTitle("DO IT NOW")
    }
}
