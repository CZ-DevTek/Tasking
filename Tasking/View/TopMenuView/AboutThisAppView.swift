//
//  InfoView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 29/9/24.

import SwiftUI

struct AboutThisAppView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .customizeMenuBackground()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        Text("""
                        This task manager app helps you organize your tasks based on their priority and completion. The Eisenhower Matrix, also known as the Urgent-Important Matrix, is a powerful time management tool that helps prioritize tasks based on their urgency and importance.
                        
                        - **Improved Decision-Making**: Categorizing tasks into four quadrants helps focus on what truly matters.
                        - **Enhanced Productivity**: Ensures time and energy are spent on important tasks, not distractions.
                        - **Reduce Stress**: Staying organized avoids feeling overwhelmed by too many tasks.
                        - **Better Time Allocation**: Encourages scheduling time for long-term growth activities.
                        - **Focus on Priorities**: Minimizes procrastination and distractions.
                        - **Improve Delegation**: Encourages delegating urgent but not important tasks.
                        """)
                        .font(.body)
                        .padding()
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("About This App", displayMode: .inline)
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
    AboutThisAppView()
}
