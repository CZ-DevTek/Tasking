//
//  Fonts.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 5/10/24.

import SwiftUI

struct CustomFont {
    let font: Font
    let color: Color
    
    static let title = CustomFont(font: .custom("Avenir Next Bold", size: 34), color: .white)
    static let subtitle = CustomFont(font: .custom("Avenir Next Bold", size: 20), color: .white)
    static let body = CustomFont(font: .custom("Avenir Next Bold", size: 18), color: .white)
    static let footnote = CustomFont(font: .custom("Avenir Next Bold", size: 12), color: .white)
}

extension Color {
    static let customGreen = Color(red: 0.0, green: 0.5, blue: 0.2)
    static let customYellow = Color(red: 1.0, green: 0.6, blue: 0.2)
    static let customBlue = Color(red: 0.1, green: 0.2, blue: 0.5)
    static let customRed = Color(red: 0.5, green: 0.1, blue: 0.1)
}
