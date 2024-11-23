//
//  Background.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 26/10/24.

import SwiftUI

struct MenuBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.88, green: 1.0, blue: 1.0),   // whiteblue
                    Color(red: 0.68, green: 0.85, blue: 0.9)  // Blue
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
    func customizeMenuBackground() -> some View {
        self.modifier(MenuBackgroundModifier())
    }
}



