//
//  User.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import Foundation

struct User: Codable, Hashable {
    let login: String
    let avatarUrl: String
    var name: String?
    var bio: String?
    var location: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String?
    let following: Int
    let followers: Int
    let createdAt: String
}
