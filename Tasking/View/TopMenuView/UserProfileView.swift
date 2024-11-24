//
//  UserProfileView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.

import SwiftUI

struct UserProfileView: View {
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var profileSaved: Bool = false
    @State private var showToast: Bool = false
    @ObservedObject private var userProfileManager = UserProfileManager()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .customizeMenuBackground()
                    .ignoresSafeArea()
                
                Form {
                    Section(header: Text("Profile Details")) {
                        if let profile = userProfileManager.getUserProfile() {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Name: \(profile.userName)")
                                    .font(.subheadline)
                                Text("Email: \(profile.userEmail)")
                                    .font(.subheadline)
                            }
                            .padding(.bottom, 10)
                        }
        
                        VStack(alignment: .leading, spacing: 15) {
                            TextField("Enter your name", text: $userName)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            
                            TextField("Enter your email", text: $userEmail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    Button(action: saveProfile) {
                        Text(profileSaved ? "Edit Profile" : "Save Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(userEmail.isEmpty || userName.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(userEmail.isEmpty || userName.isEmpty)
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                
                if showToast {
                    VStack {
                        Spacer()
                        Text("Profile Saved Successfully")
                            .font(.subheadline)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.3), value: showToast)
                    }
                }
            }
            .navigationBarTitle("User Profile", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.white)
            })
            .onAppear {
                if let profile = userProfileManager.getUserProfile() {
                    userName = profile.userName
                    userEmail = profile.userEmail
                    profileSaved = true
                }
            }
        }
    }
    
    private func saveProfile() {
        guard !userEmail.isEmpty && !userName.isEmpty else { return }
        
        let profile = UserProfile(id: UUID().uuidString, userName: userName, userEmail: userEmail)
        userProfileManager.saveUserProfile(userProfile: profile)
        profileSaved = true

        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
