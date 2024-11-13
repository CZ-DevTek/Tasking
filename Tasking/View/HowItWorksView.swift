//
//  HowItWorksView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 13/11/24.
//

import SwiftUI

struct HowItWorksView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
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
    HowItWorksView()
}
