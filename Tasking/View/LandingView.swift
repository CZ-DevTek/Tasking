//
//  LandingView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 28/9/24.

import SwiftUI

struct LandingView: View {
    @State private var tickRotation: Double = 0
    
    var body: some View {
        VStack {
            TasksLogoView()
                .frame(width: 50, height: 100)
                .padding(.bottom, 20)
            HStack(spacing: 0) {
                Text("T")
                    .foregroundColor(.blue)
                
                Text("✔︎")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.green)
                    .rotationEffect(.degrees(tickRotation))
                    .animation(.easeInOut(duration: 2), value: tickRotation)
                
                Text("S")
                    .foregroundColor(.yellow)
                
                Text("K")
                    .foregroundColor(.red)
                
                Text("S")
                    .foregroundColor(.black)
            }
            .font(.custom("Avenir Next Bold", size: 80))
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        tickRotation = 215
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            tickRotation = 160
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                tickRotation = 180
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LandingView()
}
