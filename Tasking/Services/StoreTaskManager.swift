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
    func removeTask(with id: UUID) {
        tasks.removeAll { $0.id == id }
    }
    
    func updateTask(id: UUID, newName: String) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].name = newName
        }
    }
    func moveTasks(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        tasks.move(fromOffsets: indices, toOffset: newOffset)
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
            case .importantAndUrgent:
                doItNowTasks.append(task)
            case .importantButNotUrgent:
                scheduleItTasks.append(task)
            case .urgentButNotImportant:
                delegateItTasks.append(task)
            case .notImportantNotUrgent:
                doItLaterTasks.append(task)
        }
        
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
    
    func getTasks(for priority: Priority) -> [Task] {
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
    func color(for task: Task) -> Color {
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
    func color(for priority: Priority) -> Color {
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
    func handleTaskTap(task: Task, selectedTab: Binding<Int>) {
        selectedTab.wrappedValue = 2
    }
}


extension TaskManager {
    var allPriorityTasks: [Task] {
        return  doItNowTasks + scheduleItTasks + delegateItTasks + doItLaterTasks
    }
    var sortedTasks: [Task] {
        return allPriorityTasks.sorted { (task1, task2) -> Bool in
            let priority1 = priority(for: task1)
            let priority2 = priority(for: task2)
            return priority1.rawValue < priority2.rawValue
        }
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
        } else {
            return .notImportantNotUrgent
        }
    }
}


