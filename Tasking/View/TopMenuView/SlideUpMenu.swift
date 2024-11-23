//
//  SlideUpMenu.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 24/11/24.
//
import SwiftUI

struct SlideUpMenu: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button("Profile") {
                showMenu = false
                // Add navigation to Profile view
            }
            Button("About this App") {
                showMenu = false
                // Add navigation to About view
            }
            Button("How it works?") {
                showMenu = false
                // Add navigation to How it works view
            }
            Button("Statistics") {
                showMenu = false
                // Add navigation to Statistics view
            }
            Button("Feedback") {
                showMenu = false
                // Add navigation to Feedback view
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
    }
}

