//
//  TabBar.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 27/10/24.
//

import SwiftUI

struct CustomTabBarAppearance {
    static func configure() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .orange
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.orange]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

