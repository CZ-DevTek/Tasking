//
//  AppSettings.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var currentLanguage: String = Bundle.main.preferredLocalizations.first ?? "en"
    
    func changeLanguage(to code: String) {
        guard currentLanguage != code else { return }
        currentLanguage = code
        Bundle.setLanguage(code)
    }
}
