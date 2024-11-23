//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct HomeView: View {
    @StateObject private var taskManager = TaskManager()
    @StateObject private var userProfileManager = UserProfileManager()
    @State private var selectedTab: Int = 0
    @State private var presentedViews: [Int: Binding<PresentationMode>] = [:]
    @State private var isShowingAbout = false
    @State private var isShowingHowItWorks = false
    @State private var isShowingStatistics = false
    @State private var isShowingFeedback = false
    @State private var isShowingProfile = false
    @State private var selectedPriority: Priority = .importantAndUrgent
    
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
                    Menu {
                        Button("Profile") {
                            isShowingProfile.toggle()
                        }
                        Button("About this App") {
                            isShowingAbout.toggle()
                        }
                        Button("How it works?") {
                            isShowingHowItWorks.toggle()
                        }
                        Button("Statistics") {
                            selectedPriority = .importantAndUrgent
                            isShowingStatistics.toggle()
                        }
                        Button("Feedback") {
                            if userProfileManager.getUserProfile() == nil {
                                isShowingProfile.toggle()
                            } else {
                                isShowingFeedback.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $isShowingProfile) {
                UserProfileView()
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $isShowingAbout) {
                AboutThisAppView()
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $isShowingHowItWorks) {
                HowItWorksView()
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $isShowingStatistics) {
                StatisticsView(priority: selectedPriority)
                    .environmentObject(taskManager)
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $isShowingStatistics) {
                StatisticsView(priority: selectedPriority)
                    .environmentObject(taskManager)
                    .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $isShowingFeedback) {
                FeedbackView()
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
