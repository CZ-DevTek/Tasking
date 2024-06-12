//
//  TaskModel.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import Foundation

struct Task: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var priority: Priority?
}

enum Priority: String, Codable, Hashable {
    case importantButNotUrgent = "Important but not urgent"
    case importantAndUrgent = "Important and urgent"
    case notImportantNotUrgent = "Not important and not urgent"
    case urgentButNotImportant = "Urgent but not important"
}
