//
//  PersistenceManager.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/6/22.
//

import Foundation

enum ActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "Favorites"
    }
    
    static func update(favorite: Follower, actionType: ActionType, completion: @escaping (Errors?) -> Void) {
        getFavorites { result in
            switch result {
            case .success(let favorites):
                var tempArray = favorites
                switch actionType {
                case .add:
                    guard !tempArray.contains(favorite) else {
                        completion(.inFavorites)
                        return
                    }
                    tempArray.append(favorite)
                case .remove:
                    tempArray.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: tempArray))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func getFavorites(completion: @escaping(Result<[Follower], Errors>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        }
        catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> Errors? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }
        catch {
            return .unableToFavorite
        }
    }
}

