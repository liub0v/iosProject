//
//  ViewController.swift
//  Photoflix
//
//  Created by Liubov Kurets on 26/07/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let vcNome = UINavigationController(rootViewController: HomeViewController())
        let vcUpcoming = UINavigationController(rootViewController: UpcomingViewController())

        let vcSearch = UINavigationController(rootViewController: SearchViewController())

        let vcWatchList = UINavigationController(rootViewController: WatchListViewController())
        
        
        vcNome.tabBarItem.image = UIImage(systemName: "house")
        vcUpcoming.tabBarItem.image = UIImage(systemName: "play.circle")
        vcSearch.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vcWatchList.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        vcNome.title = "Home"
        vcUpcoming.title = "Coming Soon"
        vcSearch.title = "Top search"
        vcWatchList.title = "Watch List"
        
        tabBar.tintColor = .label
        
        setViewControllers([vcNome, vcUpcoming, vcSearch, vcWatchList], animated: true)
        
    }
    
    
}

