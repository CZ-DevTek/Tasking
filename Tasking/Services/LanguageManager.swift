//
//  AppSettings.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

class LanguageManager: ObservableObject {
    @Published var currentLanguage: String = "en" {
            didSet {
                saveLanguagePreference()
                Bundle.setLanguage(currentLanguage)
                NotificationCenter.default.post(name: .languageChanged, object: nil)
            }
        }
    private var userProfileManager = UserProfileManager()

    init() {
        if let savedProfile = userProfileManager.getUserProfile() {
            currentLanguage = savedProfile.language
        } else {
            currentLanguage = "en"
        }
        let isIgnoringAppSettingsLanguage = UserDefaults.standard.bool(forKey: "isIgnoringAppSettingsLanguage")
        
        if !isIgnoringAppSettingsLanguage {
            Bundle.setLanguage(currentLanguage)
        } else {
            if let savedLanguage = UserDefaults.standard.string(forKey: "language") {
                currentLanguage = savedLanguage
            }
        }
    }
    
    private func saveLanguagePreference() {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
            UserDefaults.standard.synchronize()
        }

    func changeLanguage(to code: String) {
        guard currentLanguage != code else { return }
        currentLanguage = code
        UserDefaults.standard.set(code, forKey: "language")
        Bundle.setLanguage(code)
        userProfileManager.updateLanguage(to: code)
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }
    func syncWithSelectedLanguage(_ selectedLanguage: String) {
            if currentLanguage != selectedLanguage {
                currentLanguage = selectedLanguage
            }
        }
}

extension Notification.Name {
    static let languageChanged = Notification.Name("languageChanged")
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
