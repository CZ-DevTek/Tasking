//
//  FoldingButtonBar.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 28/10/24.
//

import SwiftUI

struct FoldingButtonBar: View {
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var isExpanded: Bool
    let action: (Priority) -> AnyView
    
    var body: some View {
        HStack {
            ForEach(Priority.allCases, id: \.self) { priority in
                NavigationLink(destination: action(priority)) {
                    Circle()
                        .fill(taskManager.color(for: priority)) 
                        .frame(width: 60, height: 60)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
    }
}
