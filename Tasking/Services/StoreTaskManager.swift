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
    
    @Published var scheduleItTasks: [Task] = []
    @Published var doItNowTasks: [Task] = []
    @Published var doItLaterTasks: [Task] = []
    @Published var delegateItTasks: [Task] = []
    
    @Published var completedTasks: [Task] = []
    
    private let tasksKey = "tasksKey"
    private let priorityTasksKey = "priorityTasksKey"
    private let completedTasksKey = "completedTasksKey"
    
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
    
    func updateTaskText(in taskList: inout [Task], taskID: UUID, newText: String) {
        if let index = taskList.firstIndex(where: { $0.id == taskID }) {
            taskList[index].name = newText
            saveTasks()
            savePriorityTasks()
        } else {
            print("Task not found")
        }
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
    
    func completeTask(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
        }
    }
    
    func clearCompletedTasks() {
        completedTasks.removeAll()
        saveCompletedTasks()
    }
    
    func addCompletedTask(_ task: Task) {
        completedTasks.append(task)
        saveCompletedTasks()
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
    
    func saveCompletedTasks() {
        let encoder = JSONEncoder()
        if let encodedCompletedTasks = try? encoder.encode(completedTasks) {
            UserDefaults.standard.set(encodedCompletedTasks, forKey: completedTasksKey)
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
    
    func moveTaskToPriorityList(_ task: Task, priority: Priority) {
        removeTaskFromCurrentList(task)
        
        switch priority {
            case .importantButNotUrgent:
                scheduleItTasks.append(task)
            case .importantAndUrgent:
                doItNowTasks.append(task)
            case .notImportantNotUrgent:
                doItLaterTasks.append(task)
            case .urgentButNotImportant:
                delegateItTasks.append(task)
        }
        
        saveTasks()
        savePriorityTasks()
    }
    
    func removeTaskFromCurrentList(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        scheduleItTasks.removeAll { $0.id == task.id }
        doItNowTasks.removeAll { $0.id == task.id }
        doItLaterTasks.removeAll { $0.id == task.id }
        delegateItTasks.removeAll { $0.id == task.id }
    }
    
    func getTasks(for priority: Priority) -> [Task] {
        switch priority {
            case .importantButNotUrgent:
                return scheduleItTasks
            case .importantAndUrgent:
                return doItNowTasks
            case .notImportantNotUrgent:
                return doItLaterTasks
            case .urgentButNotImportant:
                return delegateItTasks
        }
    }
    
    func moveTaskToTaskList(_ task: Task, from sourceList: Binding<[Task]>) {
        sourceList.wrappedValue.removeAll { $0.id == task.id }
        tasks.append(task)
        saveTasks()
        savePriorityTasks()
    }
    
    
    func moveTaskToCompleted(_ task: Task) {
        var updatedTask = task
        
        if delegateItTasks.contains(where: { $0.id == task.id }) {
            updatedTask.name = "Delegated: \(task.name)"
            if let index = delegateItTasks.firstIndex(where: { $0.id == task.id }) {
                delegateItTasks.remove(at: index)
                savePriorityTasks()
            }
        } else if scheduleItTasks.contains(where: { $0.id == task.id }) {
            updatedTask.name = "Scheduled: \(task.name)"
            if let index = scheduleItTasks.firstIndex(where: { $0.id == task.id }) {
                scheduleItTasks.remove(at: index)
                savePriorityTasks()
            }
        }
        
        addCompletedTask(updatedTask)
    }
    
    func shareTask(_ task: Task) {
        let taskName = task.name
        let activityVC = UIActivityViewController(activityItems: [taskName], applicationActivities: nil)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
