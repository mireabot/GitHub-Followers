//
//  User.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import Foundation

struct User: Codable, Hashable {
    var login: String
    var avatarUrl: String
    var name: String?
    var bio: String?
    var location: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String?
    var following: Int
    var followers: Int
    var createdAt: String
}
