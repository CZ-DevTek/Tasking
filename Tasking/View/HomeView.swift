//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct HomeView: View {
    @StateObject private var taskManager = TaskManager()
    @StateObject private var userProfileManager = UserProfileManager()
    @StateObject private var appSettings = AppSettings()
    @State private var selectedTab: Int = 0
    @State private var showSidebar = false
    @State private var isShowingAbout = false
    @State private var isShowingHowItWorks = false
    @State private var isShowingStatistics = false
    @State private var isShowingFeedback = false
    @State private var isShowingProfile = false
    @State private var selectedPriority: Priority = .importantAndUrgent
    @State private var isShowingLanguageSelection = false
    
    
    init() {
        CustomTabBarAppearance.configure()
    }
    
    var body: some View {
        SidebarMenu(sidebarWidth: 200, showSidebar: $showSidebar) {
            VStack(alignment: .leading, spacing: 20) {
                if let userProfile = userProfileManager.getUserProfile() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(userProfile.userName)
                            .font(.subheadline)
                            .padding(.top, 20)
                        Text(userProfile.userEmail)
                            .font(.subheadline)
                        
                        Divider()
                            .background(Color.white)
                    }
                } else {
                    if let userProfile = userProfileManager.getUserProfile() {
                        Text(userProfile.id)
                            .font(.subheadline)
                            .padding(.top, 20)
                    }
                }
                
                Button(action: { isShowingProfile.toggle() }) {
                    Label("Profile", systemImage: "person")
                }
                Button(action: { isShowingAbout.toggle() }) {
                    Label("About this App", systemImage: "info.circle")
                }
                Button(action: { isShowingHowItWorks.toggle() }) {
                    Label("How it works?", systemImage: "brain.head.profile")
                }
                Button(action: { isShowingLanguageSelection.toggle() }) {
                    Label("Languages", systemImage: "globe")
                }
                Button(action: {
                    selectedPriority = .importantAndUrgent
                    isShowingStatistics.toggle()
                }) {
                    Label("Statistics", systemImage: "chart.bar.xaxis")
                }
                Button(action: {
                    if userProfileManager.getUserProfile() == nil {
                        isShowingProfile.toggle()
                    } else {
                        isShowingFeedback.toggle()
                    }
                }) {
                    Label("Feedback", systemImage: "pencil.and.outline")
                }
            .navigationTitle("Info")
            .navigationBarTitleDisplayMode(.inline)
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(.black)
        } content: {
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
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showSidebar.toggle()
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                        }
                    }
                }
                .fullScreenCover(isPresented: $isShowingProfile) {
                    UserProfileView()
                }
                .fullScreenCover(isPresented: $isShowingAbout) {
                    AboutThisAppView()
                }
                .fullScreenCover(isPresented: $isShowingHowItWorks) {
                    HowItWorksView()
                }
                .fullScreenCover(isPresented: $isShowingLanguageSelection) {
                    LanguageSelectionView()
                        .environmentObject(taskManager)
                        .environmentObject(appSettings)
                }
                .fullScreenCover(isPresented: $isShowingStatistics) {
                    StatisticsView(priority: selectedPriority)
                        .environmentObject(taskManager)
                }
                .fullScreenCover(isPresented: $isShowingFeedback) {
                    FeedbackView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
