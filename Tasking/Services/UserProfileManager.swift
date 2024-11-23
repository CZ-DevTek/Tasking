//
//  UserProfileManager.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.
//

import SwiftUI

class UserProfileManager: ObservableObject {
    @Published private var userProfile: UserProfile?
    
    private let profileKey = "userProfile"
    
    init() {
        if UserDefaults.standard.string(forKey: "userID") == nil {
            let userID = UUID().uuidString
            UserDefaults.standard.set(userID, forKey: "userID")
            self.userProfile = UserProfile(id: "", userName: "", userEmail: "")
        } else {
            if UserDefaults.standard.string(forKey: "userID") != nil {
                self.userProfile = UserProfile(id: "", userName: "", userEmail: "")
            }
            loadUserProfile()
        }
    }
    
    func getUserProfile() -> UserProfile? {
            userProfile
        }

    func saveUserProfile(userProfile: UserProfile) {
        if let encoded = try? JSONEncoder().encode(userProfile) {
            UserDefaults.standard.set(encoded, forKey: profileKey)
        }
    }

    private func loadUserProfile() {
        if let savedProfileData = UserDefaults.standard.data(forKey: profileKey),
           let decodedProfile = try? JSONDecoder().decode(UserProfile.self, from: savedProfileData) {
            self.userProfile = decodedProfile
        }
    }
}
