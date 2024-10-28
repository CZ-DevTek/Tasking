//
//  TaskModel.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import Foundation
import SwiftUI

struct Task: Identifiable, Equatable, Hashable, Codable {
    var id = UUID()
    var name: String
    var priority: Priority?
    var hasAlarm = false
    var hasNotification = false
    var completed: Bool = false
    var scheduled: Bool = false
    
    mutating func toggleAlarm() {
        hasAlarm.toggle()
    }
    
    mutating func toggleNotification() {
        hasNotification.toggle()
    }
}

public enum Priority: String, CaseIterable, Hashable, Codable {
    case importantAndUrgent = "Important and urgent"
    case importantButNotUrgent = "Important but not urgent"
    case urgentButNotImportant = "Urgent but not important"
    case notImportantNotUrgent = "Not important nor urgent"
    
    var color: Color {
        switch self {
            case .importantAndUrgent:
                return .green
            case .importantButNotUrgent:
                return .yellow
            case .urgentButNotImportant:
                return .blue
            case .notImportantNotUrgent:
                return .red
                
        }
    }
    var sortOrder: Int {
        switch self {
            case .importantAndUrgent: return 0
            case .importantButNotUrgent: return 1
            case .urgentButNotImportant: return 2
            case .notImportantNotUrgent: return 3
        }
    }
}


