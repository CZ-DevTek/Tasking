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
                        Text(NSLocalizedString("about_this_app_description", comment: "Description of the task manager app"))
                                                    .font(.body)
                                                    .padding()
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
