//
//  TabBarController.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        setupTabs()
    }
    
    private func setupTabs() {
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesViewController()
        
        let nav1 = UINavigationController(rootViewController: searchVC)
        let nav2 = UINavigationController(rootViewController: favoritesVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "person"), tag: 1)
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2], animated: true)
    }

}
