//
//  FeedbackView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.

import SwiftUI
import MessageUI

struct FeedbackView: View {
    @State private var subject = ""
    @State private var bodyText = ""
    @State private var showMailView = false
    @State private var showToast = false
    @State private var mailErrorAlert = false
    
    var body: some View {
        VStack {
            Text("Feedback")
                .font(.largeTitle)
                .padding(.top)
            
            TextField("Subject", text: $subject)
                .padding()
                .background(.white)
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextEditor(text: $bodyText)
                .frame(height: 200)
                .cornerRadius(8)
                .padding()
                
            
            Button(action: {
                if MFMailComposeViewController.canSendMail() {
                    showMailView = true
                } else {
                    mailErrorAlert = true
                }
            }) {
                Text("Send Feedback")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(subject.isEmpty || bodyText.isEmpty ? .gray : .blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(subject.isEmpty || bodyText.isEmpty)
            .sheet(isPresented: $showMailView, onDismiss: {
                showToast = true
            }) {
                FeedbackMailView(subject: subject, body: bodyText)
            }
            .alert(isPresented: $mailErrorAlert) {
                Alert(
                    title: Text("Mail Not Available"),
                    message: Text("Please configure a mail account in your device settings to send feedback."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .ignoresSafeArea(edges: .all) 
        .modifier(MenuBackgroundModifier())
        .overlay(
            ToastView(show: $showToast, message: "Feedback sent successfully")
                .padding(.bottom, 40),
            alignment: .bottom
        )
    }
}

#Preview {
    FeedbackView()
}
