//
//  ViewController.swift
//  TeamNewsApp
//
//  Created by Павел Широкий on 17.03.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        
    }

    private func generateTabBar() {
        let viewControllers = [
        generateVC(viewController: BrowseViewController, title: "Browse", image: UIImage(systemName: "house"))
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}

