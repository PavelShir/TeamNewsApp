//
//  ViewController.swift
//  TeamNewsApp
//
//  Created by Павел Широкий on 17.03.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupTabBar()
    }

    private func generateTabBar() {
        viewControllers = [
        generateVC(viewController: BrowseViewController(), title: "Browse", image: UIImage(systemName: "house")),
        generateVC(viewController: CategoriesViewController(), title: "Categories", image: UIImage(systemName: "list.bullet.circle")),
        generateVC(viewController: BookmarksViewController(), title: "Bookmarks", image: UIImage(systemName: "bookmark")),
        generateVC(viewController: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.crop.circle"))
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBar() {
            tabBar.layer.borderWidth = 0.5
            tabBar.layer.borderColor = UIColor.lightGray.cgColor
            tabBar.layer.cornerRadius = 20
            tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }

}

