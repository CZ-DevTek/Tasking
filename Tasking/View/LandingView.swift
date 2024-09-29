//
//  LandingView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 28/9/24.
//

import SwiftUI

struct LandingView: View {
    @State private var tickRotation: Double = 0
    
    var body: some View {
        VStack {
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
            .font(.custom("Noteworthy Bold", size: 80))
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation {
                    tickRotation = 180
                }
            }
        }
    }
}
#Preview {
    LandingView()
}
