//
//  Background.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 26/10/24.

import SwiftUI

struct CustomBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.7, blue: 0.8),  // Cyan
                    Color(red: 0.0, green: 0.0, blue: 0.4)   // Dark Blue
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    func customizeBackground() -> some View {
        self.modifier(CustomBackground())
    }
}



