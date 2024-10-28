//
//  SubviewsBackgroundModifier.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 27/10/24.

import SwiftUI

struct SubviewsBackgroundModifier: ViewModifier {
    let priority: PriorityGradient
    
    func body(content: Content) -> some View {
        ZStack {
            priority.gradient
                .ignoresSafeArea()
            content
                .padding()
        }
    }
}

extension View {
    func customizeSubviewsBackground(for priority: PriorityGradient) -> some View {
        self.modifier(SubviewsBackgroundModifier(priority: priority))
    }
}

