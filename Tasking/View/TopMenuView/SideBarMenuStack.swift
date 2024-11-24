//
//  SideBarMenuStack.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 24/11/24.

import SwiftUI

struct SideBarMenuStack<SidebarContent: View, Content: View>: View {
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    let animation: Animation
    
    init(
        sidebarWidth: CGFloat,
        showSidebar: Binding<Bool>,
        animation: Animation = .easeInOut(duration: 0.3),
        @ViewBuilder sidebar: () -> SidebarContent,
        @ViewBuilder content: () -> Content
    ) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        self.animation = animation
        self.sidebarContent = sidebar()
        self.mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .frame(width: sidebarWidth)
                .foregroundColor(.white)
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .offset(x: showSidebar ? 0 : -sidebarWidth)
                .animation(animation, value: showSidebar)
            
            mainContent
                .overlay(
                    showSidebar ? Color.gray.opacity(0.3)
                        .onTapGesture { showSidebar = false } : nil
                )
                .offset(x: showSidebar ? sidebarWidth : 0)
                .animation(animation, value: showSidebar)
        }
        .foregroundColor(.white)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

