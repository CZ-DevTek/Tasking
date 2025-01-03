//
//  HomeView.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 12/6/24.

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @StateObject private var taskManager = TaskManager()
    @StateObject private var userProfileManager = UserProfileManager()
    @State private var selectedTab: Int = 0
    @State private var showSidebar = false
    @State private var isShowingAbout = false
    @State private var isShowingHowItWorks = false
    @State private var isShowingStatistics = false
    @State private var isShowingFeedback = false
    @State private var isShowingProfile = false
    @State private var selectedPriority: Priority = .importantAndUrgent
    @State private var isShowingLanguageSelection = false
    @State private var currentLanguage: String = "en"
    
    
    init() {
        CustomTabBarAppearance.configure()
        NotificationCenter.default.addObserver(
            forName: .languageChanged,
            object: nil,
            queue: .main
        ) { [self] notification in
            updateLanguage()
        }
    }

    private func updateLanguage() {
        self.currentLanguage = Bundle.currentLanguage
    }
    
    var body: some View {
        SidebarMenu(sidebarWidth: 200, showSidebar: $showSidebar) {
            VStack(alignment: .leading, spacing: 20) {
                    TasksLogoView()
                        .frame(width: 20, height: 50)
                        .padding(.leading, 20)
                if let userProfile = userProfileManager.getUserProfile() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(userProfile.userName)
                            .font(.subheadline)
                            .padding(.top, 20)
                        Text(userProfile.userEmail)
                            .font(.subheadline)
                        Text(NSLocalizedString("welcome_message", comment: "Welcome message"))
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
                    Label(NSLocalizedString("Profile", comment: "Profile"), systemImage: "person")
                }
                Button(action: { isShowingAbout.toggle() }) {
                    Label(NSLocalizedString("About this App", comment: "About this App"), systemImage: "info.circle")
                }
                Button(action: { isShowingHowItWorks.toggle() }) {
                    Label(NSLocalizedString("How it works?", comment: "How it works?"), systemImage: "brain.head.profile")
                }
                Button(action: { isShowingLanguageSelection.toggle() }) {
                    Label(NSLocalizedString("Languages", comment: "Languages"), systemImage: "globe")
                }
                Button(action: {
                    selectedPriority = .importantAndUrgent
                    isShowingStatistics.toggle()
                }) {
                    Label(NSLocalizedString("Statistics", comment: "Statistics"), systemImage: "chart.bar.xaxis")
                }
                Button(action: {
                    if userProfileManager.getUserProfile() == nil {
                        isShowingProfile.toggle()
                    } else {
                        isShowingFeedback.toggle()
                    }
                }) {
                    Label(NSLocalizedString("Feedback", comment: "Feedback"), systemImage: "pencil.and.outline")
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
                            Text(NSLocalizedString("Tasks", comment: "Tasks"))
                        }
                        .tag(0)
                        .environmentObject(taskManager)
                    
                    PriorityView()
                        .tabItem {
                            Image(systemName: "square.and.pencil")
                            Text(NSLocalizedString("Priorities", comment: "Priorities"))
                        }
                        .tag(1)
                        .environmentObject(taskManager)
                    
                    TasksInProcessView(selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "list.bullet.clipboard")
                            Text(NSLocalizedString("On Going", comment: "On Going"))
                        }
                        .tag(2)
                        .environmentObject(taskManager)
                    
                    CompletedTasksView()
                        .tabItem {
                            Image(systemName: "checkmark.circle")
                            Text(NSLocalizedString("Completed", comment: "Completed"))
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
