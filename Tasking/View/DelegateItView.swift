//
//  DelegateItView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

struct DelegateItView: View {
    let tasks: [Task]

    var body: some View {
        VStack {
            Text("DELEGATE IT")
                .font(.largeTitle)
                .bold()
            List {
                ForEach(tasks) { task in
                    Text(task.name)
                }
            }
        }
        .navigationTitle("DELEGATE IT")
    }
}
