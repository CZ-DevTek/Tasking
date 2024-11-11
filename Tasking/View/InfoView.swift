//
//  InfoView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 29/9/24.

import SwiftUI

struct InfoView: View {
    var body: some View {
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
                Text("How it works?")
                    .font(.headline)
                    .padding()
                
                Text("""
                                
                                1. Write Down Tasks Immediately:
                                As soon as a task comes up, add it to your list so you don’t forget it.
                                2. Drag the Tasks into the Matrix:
                                Spend a few minutes sorting your tasks into the Eisenhower Matrix based on their priority:
                                "Do" (Urgent & Important)
                                "Schedule" (Important but Not Urgent)
                                "Delegate" (Urgent but Not Important)
                                "Eliminate" (Not Urgent & Not Important)
                                3. Act on Green Tasks ("Do") Right Away:
                                Start working on the "Do" tasks immediately because they are both urgent and critical.
                                4. Review "Delegate" and "Schedule" Regularly:
                                Delegate Tasks: Assign these to someone else and follow up to ensure they’re completed.
                                Schedule Tasks: Block time in your calendar to handle these tasks later.
                                5. Occasionally Check Red Tasks ("Eliminate"):
                                Even though they aren’t important now, review them periodically. Circumstances can change, and they may become relevant in the future.
                                """)
                .padding()
                .font(.body)
            }
        }
    }
}
#Preview {
    InfoView()
}
