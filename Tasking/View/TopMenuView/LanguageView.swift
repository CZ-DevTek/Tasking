//
//  LanguageView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

struct LanguageSelectionView: View {
    @EnvironmentObject var appSettings: AppSettings
    @Environment(\.dismiss) var dismiss
    @State private var showRestartAlert = false
    @State private var pendingLanguage: String?
    @Environment(\.presentationMode) var presentationMode

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

                        ForEach(availableLanguages, id: \.1) { language in
                            Button(action: {
                                handleLanguageChange(to: language.1)
                            }) {
                                Text(language.0)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(appSettings.currentLanguage == language.1 ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
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
            .alert(isPresented: $showRestartAlert) {
                Alert(
                    title: Text(NSLocalizedString("Restart Required", comment: "Restart alert title")),
                    message: Text(NSLocalizedString("To apply the language change, the app needs to restart. Do you want to restart now?", comment: "Restart alert message")),
                    primaryButton: .destructive(Text(NSLocalizedString("Restart", comment: "Restart button"))) {
                        if let language = pendingLanguage {
                            appSettings.changeLanguage(to: language)
                            exit(0)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .ignoresSafeArea()
        .customizeMenuBackground()
    }

    private func handleLanguageChange(to language: String) {
        guard appSettings.currentLanguage != language else { return }
        pendingLanguage = language
        showRestartAlert = true
    }
}
