//
//  ToastView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.
//

import SwiftUI

struct ToastView: View {
    @Binding var show: Bool
    let message: String
    
    var body: some View {
        if show {
            Text(message)
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            show = false
                        }
                    }
                }
        }
    }
}
