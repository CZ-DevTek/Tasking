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
                        Text("""
                        1. **Write Down Tasks Immediately**: 
                        Add tasks to your list as soon as they come up.

                        2. **Drag Tasks into the Matrix**: 
                        Spend time sorting tasks into the Eisenhower Matrix:
                        
                        - **"Do"** (Urgent & Important)
                        - **"Schedule"** (Important but Not Urgent)
                        - **"Delegate"** (Urgent but Not Important)
                        - **"Eliminate"** (Not Urgent & Not Important)

                        3. **Act on Green Tasks Right Away**: 
                        Start working on urgent and critical tasks immediately.

                        4. **Review "Delegate" and "Schedule" Tasks Regularly**: 
                        Delegate tasks to others and block time for important ones.

                        5. **Check Red Tasks Occasionally**: 
                        Review non-urgent, unimportant tasks periodically, as circumstances may change.
                        """)
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
