//
//  StoreTaskManager.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import Combine

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var priorityTasks: [Priority: [Task]]? = [
        .importantButNotUrgent: [],
        .importantAndUrgent: [],
        .notImportantNotUrgent: [],
        .urgentButNotImportant: []
    ]
    
    private let tasksKey = "tasksKey"
    private let priorityTasksKey = "priorityTasksKey"
    
    init() {
        loadTasks()
        loadPriorityTasks()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
        savePriorityTasks()
    }
    
    func removeTask(at index: Int) {
        tasks.remove(at: index)
        saveTasks()
        savePriorityTasks()
    }
    
    func updateTaskText(at index: Int, newText: String) {
        tasks[index].name = newText
        saveTasks()
        savePriorityTasks()
    }
    
    func updateTaskPriority(at index: Int, priority: Priority) {
        tasks[index].priority = priority
        saveTasks()
        savePriorityTasks()
    }
    
    func saveTasks() {
        let encoder = JSONEncoder()
        if let encodedTasks = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: tasksKey)
        }
    }
    func savePriorityTasks() {
        let encoder = JSONEncoder()
        if let encodedPriorityTasks = try? encoder.encode(priorityTasks) {
            UserDefaults.standard.set(encodedPriorityTasks, forKey: priorityTasksKey)
        }
    }
    
    func loadTasks() {
        let decoder = JSONDecoder()
        if let savedTasks = UserDefaults.standard.data(forKey: tasksKey),
           let decodedTasks = try? decoder.decode([Task].self, from: savedTasks) {
            tasks = decodedTasks
        }
    }
    
    func loadPriorityTasks() {
        let decoder = JSONDecoder()
        if let savedPriorityTasks = UserDefaults.standard.data(forKey: priorityTasksKey),
           let decodedPriorityTasks = try? decoder.decode([Priority: [Task]].self, from: savedPriorityTasks) {
            priorityTasks = decodedPriorityTasks
        }
    }
}
