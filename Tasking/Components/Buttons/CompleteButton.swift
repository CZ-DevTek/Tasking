//
//  CompleteButton.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.
//
import SwiftUI

struct TapToCompleteTask: View {
    @State private var isCompleted: Bool = false
    let task: Task
    let color: Color
    let font: Font
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isCompleted.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        action()
                    }
                }
            }) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle.fill")
                    .foregroundColor(isCompleted ? .white : color)
                    .font(.title)
            }
            .padding(.trailing, 8)
            
            Text(task.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(isCompleted ? 0.5 : 1)
                .font(font)
                .foregroundColor(color)
        }
        .contentShape(Rectangle())
    }
}
