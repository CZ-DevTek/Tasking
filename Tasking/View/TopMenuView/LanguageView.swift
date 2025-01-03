//
//  LanguageView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

struct LanguageSelectionView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss
    @State private var pendingLanguage: String?
    @Environment(\.presentationMode) var presentationMode
    @State private var isIgnoringAppSettingsLanguage: Bool = UserDefaults.standard.bool(forKey: "isIgnoringAppSettingsLanguage")
    
    
    private let availableLanguages = [
        ("English", "en"),
        ("Español", "es"),
        ("Français", "fr"),
        ("Русский", "ru")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .customizeMenuBackground()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        Text(NSLocalizedString("select_language", comment: "Label for selecting app language"))
                            .font(.headline)
                            .padding(.bottom, 20)
                        
                        Toggle(isOn: $isIgnoringAppSettingsLanguage) {
                            Text(NSLocalizedString("Ignore Language by Location", comment:"Ignore Language by Location"))
                                .font(.subheadline)
                                .padding()
                        }
                        .padding(.horizontal)
                        .onChange(of: isIgnoringAppSettingsLanguage) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "isIgnoringAppSettingsLanguage")
                        }
                        ForEach(availableLanguages, id: \.1) { language in
                            Button(action: {
                                handleLanguageChange(to: language.1)
                            }) {
                                Text(language.0)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(languageManager.currentLanguage == language.1 ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                        }
                        Button(action: {
                            restartApp()
                        }) {
                            Text(NSLocalizedString("Restart Language and App", comment: "Restart Language and App"))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle(NSLocalizedString("app_language", comment: "App Language"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.white)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                }
            }
        }
        .ignoresSafeArea()
        .customizeMenuBackground()
    }
    
    private func handleLanguageChange(to language: String) {
        if isIgnoringAppSettingsLanguage {
            languageManager.changeLanguage(to: language)
        } else {
            guard languageManager.currentLanguage != language else { return }
            pendingLanguage = language
        }
    }
    private func restartApp() {
        exit(0)
    }
}
