//
//  SideBarMenuDisplay.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 24/11/24.
//

import SwiftUI

struct SideBarMenuDisplayView<SidebarContent: View, Content: View>: View {
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    let sidebarContent: SidebarContent
    let mainContent: Content

    init(
        sidebarWidth: CGFloat,
        showSidebar: Binding<Bool>,
        @ViewBuilder sidebar: () -> SidebarContent,
        @ViewBuilder content: () -> Content
    ) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        self.sidebarContent = sidebar()
        self.mainContent = content()
    }

    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .frame(width: sidebarWidth)
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .offset(x: showSidebar ? 0 : -sidebarWidth)
                .animation(.easeInOut, value: showSidebar)

            mainContent
                .overlay(
                    showSidebar ? Color.black.opacity(0.3)
                        .onTapGesture {
                            showSidebar = false
                        }
                        : nil
                )
                .offset(x: showSidebar ? sidebarWidth : 0)
                .animation(.easeInOut, value: showSidebar)
        }
    }
}

