//
//  SettingsCoordinator.swift
//  FileManager
//
//  Created by Алексей Голованов on 07.11.2023.
//

import UIKit

final class SettingsCoordinator: Coordinatable {
    var navigationController: UINavigationController
    private var fileManagerService = FileManagerService.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let viewController = SettingsViewController(coordinator: self)
        navigationController.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "gearshape.fill"),
            tag: 0)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func changePassword() {
        KeychainService.shared.deletePassword()
        let viewController = AuthorizationViewController(coordinator: AppCoordinator(navigationController: navigationController))
        viewController.title = "Смена пароля"
        navigationController.present(viewController, animated: true)
    }
}
