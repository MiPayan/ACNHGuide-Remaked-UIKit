//
//  TabBarViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTabBarAppareance()
    }
    
    func configureNavigation() {
        let controllers = [
            FishViewController(),
            SeaCreatureViewController(),
            BugViewController(),
            FossilViewController(),
            ProgressDashboardViewController()
        ]
        
        let titles = [
            "fish".localized,
            "sea_creature".localized,
            "bug".localized,
            "fossil".localized,
            "progress".localized
        ]
        
        let images = [
            UIImage(systemName: "fish"),
            UIImage(systemName: "water.waves"),
            UIImage(systemName: "ant"),
            UIImage(systemName: "globe.asia.australia"),
            UIImage(systemName: "leaf")
        ]
        
        let navigationControllers = controllers.enumerated().map { (index, controller) in
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.tabBarItem = UITabBarItem(title: titles[index], image: images[index], tag: index)
            navigationController.navigationBar.isHidden = true
            return navigationController
        }
        setViewControllers(navigationControllers, animated: true)
    }
    
    func configureTabBarAppareance() {
        UITabBar.appearance().barTintColor = UIColor(named: "ColorSand")
        UITabBar.appearance().backgroundColor = UIColor(named: "ColorSand")
        UITabBar.appearance().unselectedItemTintColor = .black
        UITabBar.appearance().tintColor = .brown
    }
}
