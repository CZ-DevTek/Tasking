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
                    Color(red: 0.0, green: 0.0, blue: 0.0), // Black
                    Color(red: 0.0, green: 0.0, blue: 0.4)   // e-Blue
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



