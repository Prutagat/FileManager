//
//  SceneDelegate.swift
//  FileManager
//
//  Created by Алексей Голованов on 30.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: AppCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        
        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

