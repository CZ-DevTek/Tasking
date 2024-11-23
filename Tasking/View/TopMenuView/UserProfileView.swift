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
            VStack {
                Form {
                    Section(header: Text("Profile")) {
                        if let profile = userProfileManager.getUserProfile() {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Name: \(profile.userName)")
                                    .font(.subheadline)
                                Text("Email: \(profile.userEmail)")
                                    .font(.subheadline)
                            }
                            .padding(.bottom, 20)
                        }
                        
                        TextField("Enter your name", text: $userName)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(5)
                        
                        TextField("Enter your email", text: $userEmail)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(5)
                    }
                    .foregroundColor(.black)
                    
                    Button(action: saveProfile) {
                        Text(profileSaved ? "Edit Profile" : "Save Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(userEmail.isEmpty || userName.isEmpty ? .gray : .blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(userEmail.isEmpty || userName.isEmpty)
                }
                
                if showToast {
                    Text("Profile Saved Successfully")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding()
                        .cornerRadius(10)
                        .transition(.move(edge: .top))
                        .animation(.easeInOut(duration: 0.5), value: showToast)
                        .padding(.top, 20)
                }
            }
            .modifier(MenuBackgroundModifier())
            .navigationBarTitle("User Profile")
            .modifier(MenuBackgroundModifier())
        }
        .onAppear {
            if let profile = userProfileManager.getUserProfile() {
                userName = profile.userName
                userEmail = profile.userEmail
                profileSaved = true
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    UserProfileView()
}
