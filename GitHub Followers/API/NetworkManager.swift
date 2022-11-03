//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import UIKit

class Networkmanager {
    static let shared = Networkmanager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], Errors>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=50&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            // If unable to perform request
            if let _ = err {
                completion(.failure(.checkConnection))
                return
            }
            // If unsuccessfull result, 200 - OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            // If data was incorrect
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
                
            } catch {
                completion(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping(Result<User, Errors>) -> Void) {
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            // If unable to perform request
            if let _ = err {
                completion(.failure(.checkConnection))
                return
            }
            // If unsuccessfull result, 200 - OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            // If data was incorrect
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
                
            } catch {
                completion(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
}
