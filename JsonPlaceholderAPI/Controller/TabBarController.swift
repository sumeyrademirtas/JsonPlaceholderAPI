//
//  ViewController.swift
//  JsonPlaceholderAPI
//
//  Created by Sümeyra Demirtaş on 3.09.2024.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTabs()
    }

    private func setUpTabs() {
        let usersVC = UsersListVC()
        let searchVC = SearchVC()

        let nav1 = UINavigationController(rootViewController: usersVC)
        let nav2 = UINavigationController(rootViewController: searchVC)

        nav1.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.3.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)

        setViewControllers([nav1, nav2], animated: true)
    }
}
