//
//  AppCoordinator.swift
//  FileManager
//
//  Created by Алексей Голованов on 01.11.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = AuthorizationViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showTabBarController() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
    }
}
