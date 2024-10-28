//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct HomeView: View {
    @StateObject private var taskManager = TaskManager()
    @State var isShowingInfo = false
    @State private var selectedTab: Int = 0
    @State private var presentedViews: [Int: Binding<PresentationMode>] = [:]
    
    init() {
        CustomTabBarAppearance.configure()
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                TaskListView()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Tasks")
                    }
                    .tag(0)
                    .environmentObject(taskManager)
                
                PriorityView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Priorities")
                    }
                    .tag(1)
                    .environmentObject(taskManager)
                
                TasksInProcessView(selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                        Text("On Going")
                    }
                    .tag(2)
                    .environmentObject(taskManager)
                
                CompletedTasksView()
                    .tabItem {
                        Image(systemName: "checkmark.circle")
                        Text("Completed")
                        
                    }
                    .tag(3)
                    .environmentObject(taskManager)
            }
            .navigationTitle("Task Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingInfo.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingInfo) {
                InfoView()
                    .presentationDetents([.medium, .large])
            }
            .onChange(of: selectedTab) { newValue, _ in
                dismissCurrentView()
            }
        }
    }
    private func dismissCurrentView() {
        if let binding = presentedViews[selectedTab] {
            binding.wrappedValue.dismiss()
        }
    }
    
    private func storePresentationMode(for index: Int, mode: Binding<PresentationMode>) {
        presentedViews[index] = mode
    }
}
#Preview {
    HomeView()
}
