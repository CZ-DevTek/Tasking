//
//  Background.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 26/10/24.
//

import SwiftUI

struct CustomBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.orange]),
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



