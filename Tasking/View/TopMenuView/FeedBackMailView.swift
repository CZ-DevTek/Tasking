//
//  FeedbackForm.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.

import SwiftUI
import MessageUI

struct FeedbackMailView: UIViewControllerRepresentable {
    let subject: String
    let body: String
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = context.coordinator
        mailComposer.setToRecipients(["devcz@icloud.com"])
        mailComposer.setSubject(subject)
        mailComposer.setMessageBody(body, isHTML: false)
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: FeedbackMailView
        
        init(_ parent: FeedbackMailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
