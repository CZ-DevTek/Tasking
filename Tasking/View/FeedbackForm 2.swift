//
//  FeedbackForm 2.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.
//


import SwiftUI
import MessageUI

struct FeedbackForm: View {
    @State private var feedbackText = ""
    @State private var showMailView = false
    @State private var showMailAlert = false
    @State private var showProfileAlert = false

    @ObservedObject var userProfileManager = UserProfileManager() // Make sure to get user profile
    
    var body: some View {
        VStack {
            Text("Your Feedback")
                .font(.headline)
                .padding()

            TextEditor(text: $feedbackText)
                .frame(height: 200)
                .border(Color.gray)
                .padding()

            Button(action: {
                // Check if user has an email registered
                if let _ = userProfileManager.userProfile?.userEmail {
                    if MFMailComposeViewController.canSendMail() {
                        showMailView = true
                    } else {
                        showMailAlert = true
                    }
                } else {
                    // Show alert if no email is found
                    showProfileAlert = true
                }
            }) {
                Text("Send Feedback")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(feedbackText.isEmpty)
            .padding()
            .alert(isPresented: $showMailAlert) {
                Alert(
                    title: Text("Mail Not Available"),
                    message: Text("Please configure a mail account in your device settings to send feedback."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $showProfileAlert) {
                Alert(
                    title: Text("Missing Email"),
                    message: Text("In order to send feedback, please update your email in your profile."),
                    primaryButton: .default(Text("Go to Profile")) {
                        // Navigate to profile view when the user clicks "Go to Profile"
                        // You may need to manage navigation in your app to show the profile view
                        // For example, you can use a navigation link or manually push to the profile view.
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .sheet(isPresented: $showMailView) {
            FeedbackView(isShowing: $showMailView, feedbackMessage: feedbackText)
        }
        .padding()
    }
}

#Preview {
    FeedbackForm()
}
