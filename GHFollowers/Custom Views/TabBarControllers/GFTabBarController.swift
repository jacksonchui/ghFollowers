//
//  GFTableBarController.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/24/21.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers            = [createSearchNC(), createfavoritesNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        // Configure the ViewController before using it.
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // better to write a simpler second function...rather than 5 params
    func createfavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListViewController()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
 
}
