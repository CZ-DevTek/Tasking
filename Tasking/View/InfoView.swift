//
//  InfoView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 29/9/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("About This App")
                    .font(.headline)
                    .padding()
                
                Text("""
                This task manager app helps you organize your tasks based on priority and completion. You can manage tasks, set priorities, and view completed tasks.
                On the first button called Tasks you can write all your tasks. After the next steps is to go to the button called priorities where you drag the tasks by their priority and completion in a very easy method, then go to every color list to check them, and the end in the last button called completed you may see a list with the completed taks.
""")
                .padding()
                Text("About This Method")
                    .font(.headline)
                    .padding()
                
                Text("""
                                Focus on Important Tasks: Use the Eisenhower Matrix (urgent/important) to prioritize tasks based on their impact and deadlines. That allows you to organize, to achieve your goals, and down your stress.
                                -Important & Urgent: 
                                Do these tasks immediately. Are the activities that you can do fast and remove from your head.
                                -Important but Not Urgent: 
                                Schedule them to ensure they get done. As soon as you schedule them, as soon they are out of your head.
                                -Urgent but Not Important: 
                                Delegate these tasks. If they are not so important but htye need to be done, ask somebody to do them.
                                -Not Important & Not Urgent: 
                                Write, avoid, or eliminate these tasks. This is a great place for ideas. Some might turn into real tasks, while others go to the trash.
                                """)
                .padding()
                .font(.body)
            }
        }
    }
}
#Preview {
    HomeView()
}
