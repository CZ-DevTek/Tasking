//
//  PearlEffect.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 27/10/24.

import SwiftUI

enum PriorityGradient {
    case blue
    case red
    case yellow
    case green
    
    var gradient: LinearGradient {
        switch self {
        case .blue:
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.0, green: 0.7, blue: 0.8),  // Cyan
                Color(red: 0.0, green: 0.2, blue: 0.5)   // Dark blue
            ]), startPoint: .top, endPoint: .bottom)
        case .red:
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.9, green: 0.3, blue: 0.4), // orange
                Color(red: 0.5, green: 0.1, blue: 0.1)  // Red
            ]), startPoint: .top, endPoint: .bottom)
        case .yellow:
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 1.0, green: 0.9, blue: 0.6), // Light yellow
                Color(red: 1.0, green: 0.87, blue: 0.0) // Yellow
 
            ]), startPoint: .top, endPoint: .bottom)
        case .green:
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.5, green: 1.0, blue: 0.3), // Lemon green
                Color(red: 0.0, green: 0.5, blue: 0.2)  // Dark green
            ]), startPoint: .top, endPoint: .bottom)
        }
    }
}

struct GradientBackground: ViewModifier {
    let gradient: PriorityGradient
    
    func body(content: Content) -> some View {
        ZStack {
                    gradient.gradient
                        .cornerRadius(12)
                    content
                        .padding()
                }
                .frame(width: 160, height: 120)
            }
        }

extension View {
    func gradientBackground(for priority: PriorityGradient) -> some View {
        self.modifier(GradientBackground(gradient: priority))
    }
}
