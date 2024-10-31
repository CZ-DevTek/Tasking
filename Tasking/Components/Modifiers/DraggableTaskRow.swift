//
//  DraggableTaskRow.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 29/10/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DragGestureHandler: View {
    @Binding var isDragging: Bool
    @Binding var dragOffset: CGSize
    @Binding var draggedTaskCount: Int
    let color: Color
    let currentRowWidth: CGFloat
    let handleTaskDrop: (NSItemProvider) -> Void

    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)

                Text("\(draggedTaskCount)")
                    .foregroundColor(.green)
                    .font(.headline)
            }
            .padding()
            .frame(width: currentRowWidth, height: 100) 
            .background(isDragging ? .gray.opacity(0.2) : color)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            .cornerRadius(10)
            .padding(4)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                        isDragging = true
                    }
                    .onEnded { _ in
                        dragOffset = .zero
                        isDragging = false
                    }
            )
            .overlay(
                Group {
                    if isDragging {
                        Circle()
                            .stroke(.blue, lineWidth: 2)
                            .frame(width: 50, height: 50)
                            .position(x: dragOffset.width + 50, y: dragOffset.height + 50)
                            .animation(.easeInOut(duration: 0.2), value: dragOffset)
                    }
                }
            )
            .onDrop(of: [UTType.text], isTargeted: Binding.constant(false)) { providers in
                if let item = providers.first {
                    handleTaskDrop(item)
                }
                return true
            }
        }
    }
}
