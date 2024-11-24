//
//  SideBarMenuStack.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 24/11/24.

import SwiftUI

struct SidebarMenuView: View {
    @ObservedObject var userProfileManager: UserProfileManager
    @Binding var isShowingProfile: Bool
    @Binding var isShowingAbout: Bool
    @Binding var isShowingHowItWorks: Bool
    @Binding var isShowingStatistics: Bool
    @Binding var isShowingFeedback: Bool
    @Binding var selectedPriority: Priority
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let userProfile = userProfileManager.getUserProfile() {
                Text(userProfile.userName)
                    .font(.subheadline)
                    .padding(.top, 20)
                Text(userProfile.userEmail)
                    .font(.subheadline)
                Divider()
                    .background(.white)
            } else {
                Text("Guest User")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("No email available")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }

            SidebarButton(action: { isShowingProfile.toggle() }, label: "Profile", systemImage: "person")
            SidebarButton(action: { isShowingAbout.toggle() }, label: "About this App", systemImage: "info.circle")
            SidebarButton(action: { isShowingHowItWorks.toggle() }, label: "How it works?", systemImage: "brain.head.profile")
            
            SidebarButton(action: {
                selectedPriority = .importantAndUrgent
                isShowingStatistics.toggle()
            }, label: "Statistics", systemImage: "chart.bar.xaxis")
            
            SidebarButton(action: {
                if userProfileManager.getUserProfile() == nil {
                    isShowingProfile.toggle()
                } else {
                    isShowingFeedback.toggle()
                }
            }, label: "Feedback", systemImage: "pencil.and.outline")

            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .background(.black)
    }
}

struct SidebarButton: View {
    let action: () -> Void
    let label: String
    let systemImage: String
    
    var body: some View {
        Button(action: action) {
            Label(label, systemImage: systemImage)
        }
    }
}
