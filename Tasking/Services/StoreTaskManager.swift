//
//  StoreTaskManager.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.
//

import SwiftUI
import Combine

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var priorityTasks: [Priority: [Task]] = [
        .importantButNotUrgent: [],
        .importantAndUrgent: [],
        .notImportantNotUrgent: [],
        .urgentButNotImportant: []
    ] {
        willSet {
            objectWillChange.send()
        }
    }
    
    private let tasksKey = "tasksKey"
    private let priorityTasksKey = "priorityTasksKey"
    
    init() {
        loadTasks()
        loadPriorityTasks()
        sortTasksByPriority()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
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
        var task = tasks[index]
        task.priority = priority
        for (key, _) in priorityTasks {
            priorityTasks[key]?.removeAll { $0.id == task.id }
        }
        priorityTasks[priority]?.append(task)
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
    func sortTasksByPriority() {
        tasks.sort { task1, task2 in
            if let priority1 = task1.priority, let priority2 = task2.priority {
                return priority1.rawValue < priority2.rawValue
            } else {
                return false
            }
        }
    }
    func updateTaskDueDate(_ task: Task, newDate: Date) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].dueDate = newDate
            saveTasks()
        }
    }
    func completeTask(for task: Task) {
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks[index].completed.toggle()
            }
        }
    
}


