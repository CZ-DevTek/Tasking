//
//  UserProfileModel.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 23/11/24.

import Foundation

struct UserProfile: Codable, Identifiable {
    var id: String
    var userName: String
    var userEmail: String
}
