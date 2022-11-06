//
//  ReusableTabBar.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/6/22.
//

import UIKit

class ReusableTabBar: UITabBarController {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavoriteNavigationController()]
    }
    
    //MARK: - Helpers
    
    func createSearchNavigationController() -> UINavigationController {
        let searchNavigation = UINavigationController(rootViewController: SearchController())
        searchNavigation.title = "Search"
        searchNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return searchNavigation
    }
    
    func createFavoriteNavigationController() -> UINavigationController {
        let favoritesNavigation = UINavigationController(rootViewController: FavoritesController())
        favoritesNavigation.title = "Favorites"
        favoritesNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return favoritesNavigation
    }
}
