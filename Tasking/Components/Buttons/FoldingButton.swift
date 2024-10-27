//
//  FoldingButton.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 28/10/24.
//

import SwiftUI

struct FoldingButton: View {
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)
                .shadow(radius: 4)
        }
    }
}

