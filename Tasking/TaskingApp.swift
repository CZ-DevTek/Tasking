//
//  TaskingApp.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI

@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let taskManager = TaskManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(taskManager)
                .onAppear {
                    taskManager.loadTasks()
                    taskManager.loadPriorityTasks()
                }
        }
    }
}
