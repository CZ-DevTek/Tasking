//
//  TaskingApp.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var taskManager = TaskManager()
    @State private var showLandingView = true
    
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
                    .environmentObject(taskManager)
                    .onAppear {
                        taskManager.loadTasks()
                        taskManager.loadPriorityTasks()
                    }
            }
        }
    }
}
