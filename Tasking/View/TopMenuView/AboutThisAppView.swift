//
//  InfoView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 29/9/24.

import SwiftUI

struct AboutThisAppView: View {
    var body: some View {
        ZStack {
            Color.clear
                .customizeMenuBackground()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("About This App")
                        .font(.headline)
                        .padding()

                    Text("""
                    This task manager app helps you organize your tasks based on their priority and completion. The Eisenhower Matrix, also known as the Urgent-Important Matrix, is a powerful time management tool that helps prioritize tasks based on their urgency and importance.
    - Improved Decision-Making by categorizing tasks into four quadrants, this clarity helps focus on what truly matters.
    - Enhanced Productivity focusing on important tasks (both urgent and non-urgent), the matrix ensures that time and energy are spent on activities that align with long-term goals, rather than being consumed by distractions.
    - Reduce Stress categorizing tasks helps you stay organized and avoid the overwhelming feeling of having too much to do. Addressing urgent and important tasks first reduces last-minute pressures.
    - Better Time Allocation encourages scheduling time for important but not urgent tasks (Quadrant II), which often include activities like planning, learning, and building relationships. These are crucial for personal and professional growth.
    - Focus on Priorities discourages wasting time on tasks that are neither urgent nor important. It minimizes procrastination and distractions, helping you stay on track with your goals.
    - Improve Delegation in the "Urgent but Not Important" category, allowing you to focus on higher-priority responsibilities.
    """)
                    .padding()
                    .font(.body)
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .all) 
    }
}

#Preview {
    AboutThisAppView()
}
