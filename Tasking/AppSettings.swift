//
//  AppSettings.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var currentLanguage: String = "en"
    private var userProfileManager = UserProfileManager()
    
    init() {
        if let savedProfile = userProfileManager.getUserProfile() {
            currentLanguage = savedProfile.language
        } else {
            currentLanguage = "en"
        }
        Bundle.setLanguage(currentLanguage)
    }
    
    func changeLanguage(to code: String) {
        guard currentLanguage != code else { return }
        currentLanguage = code
        Bundle.setLanguage(code)
        userProfileManager.updateLanguage(to: code)
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }
}
    extension Notification.Name {
        static let languageChanged = Notification.Name("languageChanged")
    }

