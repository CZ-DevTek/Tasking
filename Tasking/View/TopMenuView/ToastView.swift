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
    let duration: TimeInterval
    
    var body: some View {
        if show {
            VStack {
                Spacer()
                Text(message)
                    .font(.body)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        show = false
                    }
                }
            }
        }
    }
}
