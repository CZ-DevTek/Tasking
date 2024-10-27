//
//  Fonts.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 5/10/24.
//

import SwiftUI

struct CustomFont {
    let font: Font
    let color: Color
    
    static let title = CustomFont(font: .custom("Avenir Next Bold", size: 34), color: .black)
    static let subtitle = CustomFont(font: .custom("Avenir Next Bold", size: 20), color: .white)
    static let body = CustomFont(font: .custom("Avenir Next Bold", size: 18), color: .black)
    static let footnote = CustomFont(font: .custom("Avenir Next Bold", size: 12), color: .white)
   
}

