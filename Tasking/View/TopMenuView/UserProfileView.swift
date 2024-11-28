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
                VStack {
                    Spacer()
                    if let profile = userProfileManager.getUserProfile() {
                        ProfileSummaryView(profile: profile)
                            .padding(.bottom, 20)
                    }
                    Spacer()
                    VStack {
                        ProfileInputFields(userName: $userName, userEmail: $userEmail)
                        
                        SaveProfileButton(
                            userName: userName,
                            userEmail: userEmail,
                            profileSaved: profileSaved,
                            saveAction: saveProfile
                        )
                    }
                    Spacer()
                }
                .padding()
                if showToast {
                    ToastView(show: $showToast, message: "Profile Saved Successfully", duration: 2)
                        .transition(.opacity)
                }
            }
            .navigationBarTitle("User Profile", displayMode: .inline)
            .navigationBarItems(leading: BackButton(action: {
                presentationMode.wrappedValue.dismiss()
            }))
            .onAppear(perform: loadUserProfile)
        }
    }

    // MARK: - Helper Methods
    private func saveProfile() {
        guard !userEmail.isEmpty, !userName.isEmpty, isValidEmail(userEmail) else { return }

        let shortUserID = String(UUID().uuidString.prefix(8))
        
        let profile = UserProfile(id: shortUserID, userName: userName, userEmail: userEmail, language: "en")
        userProfileManager.saveUserProfile(userProfile: profile)
        profileSaved = true

        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showToast = false }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func loadUserProfile() {
        if let profile = userProfileManager.getUserProfile() {
            userName = profile.userName
            userEmail = profile.userEmail
            profileSaved = true
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

// MARK: - Subviews
struct ProfileSummaryView: View {
    let profile: UserProfile

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
           
            Text("Name: \(profile.userName)")
                .font(.subheadline)
            Text("Email: \(profile.userEmail)")
                .font(.subheadline)
            Text("Language: \(profile.language)")
                .font(.subheadline)
            Text("User ID: \(profile.id)")
                .font(.subheadline)
        }
        .padding(.bottom, 10)
    }
}

struct ProfileInputFields: View {
    @Binding var userName: String
    @Binding var userEmail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField("Enter your name", text: $userName)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(8)

            TextField("Enter your email", text: $userEmail)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .scrollContentBackground(.hidden)
        .foregroundColor(.clear)
    }
}

struct SaveProfileButton: View {
    let userName: String
    let userEmail: String
    let profileSaved: Bool
    let saveAction: () -> Void

    var body: some View {
        Button(action: saveAction) {
            Text(profileSaved ? "Edit Profile" : "Save Profile")
                .frame(maxWidth: .infinity)
                .padding()
                .background(userEmail.isEmpty || userName.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(userEmail.isEmpty || userName.isEmpty)
    }
}

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}
