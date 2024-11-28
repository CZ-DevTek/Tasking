//
//  HowItWorksView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.

import SwiftUI

struct HowItWorksView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .customizeMenuBackground()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        Text(NSLocalizedString("task_manager_instructions", comment: "Task Manager Instructions"))
                                                    .font(.body)
                                                    .padding()
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("How It Works?", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.white)
            })
        }
    }
}

#Preview {
    HowItWorksView()
}
