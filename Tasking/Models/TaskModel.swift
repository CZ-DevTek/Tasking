//
//  TaskModel.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import Foundation
import SwiftUI

struct Task: Identifiable, Equatable, Hashable, Codable {
    var id = UUID()
    var name: String
    var priority: Priority?
    var dueDate: Date?
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
    case notImportantNotUrgent = "Not important and not urgent"
    
    var color: Color {
        switch self {
            case .importantAndUrgent:
                return .red
            case .importantButNotUrgent:
                return .blue
            case .urgentButNotImportant:
                return .yellow
            case .notImportantNotUrgent:
                return .green
                
        }
    }
}

