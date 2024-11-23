//
//  StoreTaskManager.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI
import Combine

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var priorityTasks: [Priority: [Task]] = [
        .importantAndUrgent: [],
        .importantButNotUrgent: [],
        .urgentButNotImportant: [],
        .notImportantNotUrgent: []
    ] {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var doItNowTasks: [Task] = []
    @Published var scheduleItTasks: [Task] = []
    @Published var delegateItTasks: [Task] = []
    @Published var doItLaterTasks: [Task] = []
    
    @Published var completedTasks: [Task] = []
   
    @Published var allCompletedTasks: [Task] = []
    @Published var completedDoTasks: [Task] = []
    @Published var completedScheduleTasks: [Task] = []
    @Published var completedDelegateTasks: [Task] = []

    
    private let tasksKey = "tasksKey"
    private let priorityTasksKey = "priorityTasksKey"
    private let completedTasksKey = "completedTasksKey"
    
    var importantAndUrgentTasksCount: Int {
        allCompletedTasks.filter { priority(for: $0) == .importantAndUrgent }.count
    }

    var importantButNotUrgentTasksCount: Int {
        allCompletedTasks.filter { priority(for: $0) == .importantButNotUrgent }.count
    }

    var urgentButNotImportantTasksCount: Int {
        allCompletedTasks.filter { priority(for: $0) == .urgentButNotImportant }.count
    }
    
    init() {
        loadTasks()
        loadPriorityTasks()
        loadCompletedTasks()
        sortTasksByPriority()
        allCompletedTasks = completedDoTasks + completedScheduleTasks + completedDelegateTasks
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
    func removeTask(with id: UUID) {
        tasks.removeAll { $0.id == id }
    }
    
    func editTask(id: UUID, newName: String) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].name = newName
        }
    }
    func moveTasks(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        tasks.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func markTaskAsCompleted(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
        }
        saveCompletedTasks()
    }
    
    func clearCompletedTasks() {
        completedTasks.removeAll()
        saveCompletedTasks()
    }
    
    func removeCompletedTask(at index: Int) {
        guard index >= 0 && index < completedTasks.count else { return }
        completedTasks.remove(at: index)
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
            UserDefaults.standard.set(encodedCompletedTasks, forKey: "completedTasksKey")
        }
        if let encodedDoTasks = try? encoder.encode(completedDoTasks) {
            UserDefaults.standard.set(encodedDoTasks, forKey: "completedDoTasksKey")
        }
        if let encodedScheduleTasks = try? encoder.encode(completedScheduleTasks) {
            UserDefaults.standard.set(encodedScheduleTasks, forKey: "completedScheduleTasksKey")
        }
        if let encodedDelegateTasks = try? encoder.encode(completedDelegateTasks) {
            UserDefaults.standard.set(encodedDelegateTasks, forKey: "completedDelegateTasksKey")
        }
    }
    
    func saveAllCompletedTasks() {
        let encoder = JSONEncoder()
        if let encodedAllCompletedTasks = try? encoder.encode(allCompletedTasks) {
            UserDefaults.standard.set(encodedAllCompletedTasks, forKey: "allCompletedTasksKey")
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
    func loadCompletedTasks() {
        let decoder = JSONDecoder()
        
        if let completedTasksData = UserDefaults.standard.data(forKey: "completedTasksKey"),
           let loadedCompletedTasks = try? decoder.decode([Task].self, from: completedTasksData) {
            completedTasks = loadedCompletedTasks
        }
        if let completedDoTasksData = UserDefaults.standard.data(forKey: "completedDoTasksKey"),
           let loadedCompletedDoTasks = try? decoder.decode([Task].self, from: completedDoTasksData) {
            completedDoTasks = loadedCompletedDoTasks
        }
        if let completedScheduleTasksData = UserDefaults.standard.data(forKey: "completedScheduleTasksKey"),
           let loadedCompletedScheduleTasks = try? decoder.decode([Task].self, from: completedScheduleTasksData) {
            completedScheduleTasks = loadedCompletedScheduleTasks
        }
        if let completedDelegateTasksData = UserDefaults.standard.data(forKey: "completedDelegateTasksKey"),
           let loadedCompletedDelegateTasks = try? decoder.decode([Task].self, from: completedDelegateTasksData) {
            completedDelegateTasks = loadedCompletedDelegateTasks
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
    
    func moveTaskToPriorityLists(_ task: Task, priority: Priority) {
        
        removeTaskFromCurrentList(task)
        
        var updatedTask = task
            updatedTask.priority = priority
        
        switch priority {
            case .importantAndUrgent:
                doItNowTasks.append(updatedTask)
            case .importantButNotUrgent:
                scheduleItTasks.append(updatedTask)
            case .urgentButNotImportant:
                delegateItTasks.append(updatedTask)
            case .notImportantNotUrgent:
                doItLaterTasks.append(updatedTask)
        }
        priorityTasks[priority]?.append(task)
        saveTasks()
        savePriorityTasks()
    }
    
    func removeTaskFromCurrentList(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        doItNowTasks.removeAll { $0.id == task.id }
        scheduleItTasks.removeAll { $0.id == task.id }
        delegateItTasks.removeAll { $0.id == task.id }
        doItLaterTasks.removeAll { $0.id == task.id }
    }
    
    func updateTasksForPriority(for priority: Priority) -> [Task] {
        switch priority {
            case .importantAndUrgent:
                return doItNowTasks
            case .importantButNotUrgent:
                return scheduleItTasks
            case .urgentButNotImportant:
                return delegateItTasks
            case .notImportantNotUrgent:
                return doItLaterTasks
        }
    }
    func getCompletedTasks(for priority: Priority) -> [Task] {
        return completedTasks.filter { $0.priority == priority }
    }
    
    func moveTaskToTaskList(_ task: Task, from sourceList: Binding<[Task]>) {
        sourceList.wrappedValue.removeAll { $0.id == task.id }
        tasks.append(task)
        saveTasks()
        savePriorityTasks()
    }
    
    func moveTaskToCompleted(_ task: Task) {
     
        var updatedTask = task
            updatedTask.completed = true
        
        if let index = doItNowTasks.firstIndex(where: { $0.id == task.id }) {
               updatedTask.name = "Done: \(task.name)"
               updatedTask.priority = .importantAndUrgent
               doItNowTasks.remove(at: index)
               savePriorityTasks()
           } else if let index = delegateItTasks.firstIndex(where: { $0.id == task.id }) {
               updatedTask.name = "Delegated: \(task.name)"
               updatedTask.priority = .urgentButNotImportant
               delegateItTasks.remove(at: index)
               savePriorityTasks()
           } else if let index = scheduleItTasks.firstIndex(where: { $0.id == task.id }) {
               updatedTask.name = "Scheduled: \(task.name)"
               updatedTask.priority = .importantButNotUrgent
               scheduleItTasks.remove(at: index)
               savePriorityTasks()
           }
        addTaskToCompletedArrays(updatedTask)
        saveCompletedTasks()
        saveAllCompletedTasks()
    }
    private func addPrefix(for priority: Priority) -> String {
        switch priority {
        case .importantAndUrgent:
            return "Done"
        case .importantButNotUrgent:
            return "Scheduled"
        case .urgentButNotImportant:
            return "Delegated"
        case .notImportantNotUrgent:
            return "Later"
        }
    }
    
    private func addTaskToCompletedArrays(_ task: Task) {
        var updatedTask = task
        updatedTask.completed = true
        
        allCompletedTasks.append(updatedTask)
        completedTasks.append(task)
        
        switch updatedTask.priority {
            case .importantAndUrgent:
                completedDoTasks.append(task)
            case .importantButNotUrgent:
                completedScheduleTasks.append(task)
            case .urgentButNotImportant:
                completedDelegateTasks.append(task)
            case .notImportantNotUrgent:
                break
            case .none:
                print("Task \(task.name) has no priority and was not added to a specific completed list.")
        }
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
    func assignColor(for task: Task) -> Color {
        if doItNowTasks.contains(where: { $0.id == task.id }) {
            return .green
        } else if scheduleItTasks.contains(where: { $0.id == task.id }) {
            return .yellow
        } else if delegateItTasks.contains(where: { $0.id == task.id }) {
            return .blue
        } else if doItLaterTasks.contains(where: { $0.id == task.id }) {
            return .red
        } else {
            return .white
        }
    }
    func assingColor(for priority: Priority) -> Color {
        switch priority {
            case .importantAndUrgent:
                return Color.green
            case .importantButNotUrgent:
                return Color.yellow
            case .urgentButNotImportant:
                return Color.blue
            case .notImportantNotUrgent:
                return Color.red
        }
    }
    func navigateTo(for task: Task) -> AnyView {
        switch priority(for: task) {
            case .importantAndUrgent:
                return AnyView(DoItNowView())
            case .importantButNotUrgent:
                return AnyView(ScheduleItView())
            case .urgentButNotImportant:
                return AnyView(DelegateItView())
            case .notImportantNotUrgent:
                return AnyView(DoItLaterView(tasks: .constant(self.doItLaterTasks)))
        }
    }
    func linkTo(for priority: Priority) -> some View {
        switch priority {
            case .importantAndUrgent:
                return AnyView(DoItNowView().environmentObject(self))
            case .importantButNotUrgent:
                return AnyView(ScheduleItView().environmentObject(self))
            case .urgentButNotImportant:
                return AnyView(DelegateItView().environmentObject(self))
            case .notImportantNotUrgent:
                return AnyView(DoItLaterView(tasks: .constant([])).environmentObject(self))
        }
    }
}
extension TaskManager {
    var allPriorityTasks: [Task] {
        return  doItNowTasks + scheduleItTasks + delegateItTasks + doItLaterTasks
    }
    var sortedTasks: [Task] {
        let tasks = allPriorityTasks.sorted { (task1, task2) -> Bool in
            let priority1 = priority(for: task1)
            let priority2 = priority(for: task2)
            return priority1.rawValue < priority2.rawValue
        }
        return tasks
    }
    func priority(for task: Task) -> Priority {
        
        if doItNowTasks.contains(where: { $0.id == task.id }) {
            return .importantAndUrgent
        } else if scheduleItTasks.contains(where: { $0.id == task.id }) {
            return .importantButNotUrgent
        } else if delegateItTasks.contains(where: { $0.id == task.id }) {
            return .urgentButNotImportant
        } else if doItLaterTasks.contains(where: { $0.id == task.id }) {
            return .notImportantNotUrgent
        }
        fatalError("Task not found in any of the priority lists.")
    }
}


