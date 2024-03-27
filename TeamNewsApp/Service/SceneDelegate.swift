//
//  SceneDelegate.swift
//  TeamNewsApp
//
//  Created by Павел Широкий on 17.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = UINavigationController(rootViewController: TabBarViewController())

        window.makeKeyAndVisible()
        
        self.window = window
    }
}

