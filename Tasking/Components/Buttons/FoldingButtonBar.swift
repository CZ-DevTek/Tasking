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
    
    var body: some View {
        VStack {
            if isExpanded {
                HStack {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        NavigationLink(destination: taskManager.linkTo(for: priority)) {
                            Rectangle()
                                .fill(taskManager.color(for: priority))
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 8)
            }
            // Fold/Unfold Button
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Circle()
                    .fill(isExpanded ? Color.orange : Color.black)
                    .frame(width: 15, height: 15)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
            }
        }
        .padding()
    }
}

