//
//  LanguageView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import SwiftUI

struct LanguageView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @State private var languages = [
        ("English", "en"),
        ("Spanish", "es"),
        ("French", "fr"),
        ("Russia", "ru")
    ]
    
    var body: some View {
        List {
            Section(header: Text(NSLocalizedString("app_language", comment: "App Language Section Header"))) {
                ForEach(languages, id: \.1) { language in
                    HStack {
                        Text(language.0)
                        Spacer()
                        if language.1 == selectedLanguage {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        setLanguage(to: language.1)
                    }
                }
            }
        }
        .navigationTitle(NSLocalizedString("select_language", comment: "Select Language Title"))
    }
    
    private func setLanguage(to languageCode: String) {
        selectedLanguage = languageCode
        Bundle.setLanguage(languageCode)
    }
}


#Preview {
    LanguageView()
}
