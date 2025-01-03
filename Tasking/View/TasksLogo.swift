//
//  TasksLogoView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 3/1/25.
//

import SwiftUI

struct TasksLogoView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let offset = size * 0.50
            
            ZStack {
                CheckmarkShape()
                    .fill(.green)
                    .rotationEffect(.degrees(0))
                    .offset(x: 0, y: -offset)

                CheckmarkShape()
                    .fill(.red)
                    .rotationEffect(.degrees(90))
                    .offset(x: offset, y: 0)

                CheckmarkShape()
                    .fill(.yellow)
                    .rotationEffect(.degrees(180))
                    .offset(x: 0, y: offset)

                CheckmarkShape()
                    .fill(.blue)
                    .rotationEffect(.degrees(270))
                    .offset(x: -offset, y: 0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct CheckmarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let start = CGPoint(x: rect.midX - rect.width * 0.4, y: rect.midY)
        let mid = CGPoint(x: rect.midX - rect.width * 0.1, y: rect.midY + rect.height * 0.12)
        let end = CGPoint(x: rect.midX + rect.width * 0.2, y: rect.midY - rect.height * 0.4)
        
        path.move(to: start)
        path.addLine(to: mid)
        path.addLine(to: end)
        
        return path.strokedPath(.init(lineWidth: rect.width * 0.25, lineCap: .square, lineJoin: .round))
    }
}

#Preview {
    TasksLogoView()
        .frame(width: 100, height: 200)
}
