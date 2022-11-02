//
//  Enums.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import Foundation


enum Errors: String, Error {
    case invalidUsername = "Username is invalid."
    case checkConnection = "Unable to complete request due to connection error."
    case invalidResponse = "Invalid response from server. Try again."
    case invalidData = "The data was received incorrect."
}
