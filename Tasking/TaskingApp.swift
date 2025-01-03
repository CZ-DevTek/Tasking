//
//  TaskingApp.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

@main
struct MyApp: App {
    @AppStorage("selectedLanguage") private var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var taskManager = TaskManager()
    @State private var showLandingView = true
    @StateObject private var languageManager = LanguageManager()
    
    
    init() {
        Bundle.setLanguage(selectedLanguage)
    }
    var body: some Scene {
        WindowGroup {
            if showLandingView {
                LandingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            showLandingView = false
                        }
                    }
            } else {
                HomeView()
                    .environmentObject(languageManager)
                    .environmentObject(taskManager)
                    .onAppear {
                        languageManager.syncWithSelectedLanguage(selectedLanguage)
                        taskManager.loadTasks()
                        taskManager.loadPriorityTasks()
                        taskManager.loadCompletedTasks()
                    }
            }
        }
    }
}
