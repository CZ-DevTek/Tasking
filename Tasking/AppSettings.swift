//
//  AppSettings.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var currentLanguage: String = "en"
    @ObservedObject private var userProfileManager = UserProfileManager()

    init() {
        if let savedProfile = userProfileManager.getUserProfile() {
            currentLanguage = savedProfile.language
            Bundle.setLanguage(currentLanguage)
        }
    }

    func changeLanguage(to code: String) {
        guard currentLanguage != code else { return }
        currentLanguage = code
        Bundle.setLanguage(code)

        userProfileManager.updateLanguage(to: code)
    }
}
