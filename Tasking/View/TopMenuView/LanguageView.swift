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

    private let availableLanguages = [
        ("English", "en"),
        ("Español", "es"),
        ("Français", "fr"),
        ("Русский", "ru")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text(NSLocalizedString("select_language", comment: "Label for selecting app language"))
                    .font(.headline)
                    .padding(.bottom, 20)

                ForEach(availableLanguages, id: \.1) { language in
                    Button(action: {
                        appSettings.changeLanguage(to: language.1)
                        dismiss()
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
            .navigationTitle(NSLocalizedString("app_language", comment: "App Language"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
