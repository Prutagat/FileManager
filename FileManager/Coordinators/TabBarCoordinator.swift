//
//  TabBarCoordinator.swift
//  FileManager
//
//  Created by Алексей Голованов on 07.11.2023.
//

import UIKit

final class TabBarCoordinator: Coordinatable {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.isHidden = true
        let tabBarController = UITabBarController()
        let fileManagerCoordinator = FileManagerCoordinator(navigationController: UINavigationController())
        fileManagerCoordinator.start()
        let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())
        settingsCoordinator.start()
        tabBarController.viewControllers = [fileManagerCoordinator.navigationController, settingsCoordinator.navigationController]
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
