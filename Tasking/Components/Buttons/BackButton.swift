//
//  BackButton.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 24/11/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation {
                isPressed.toggle()
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .font(.title)
                    .foregroundColor(.white)
                    .scaleEffect(isPressed ? 2.0 : 0.5)
                
            }
            .padding()
            .background(.clear)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
