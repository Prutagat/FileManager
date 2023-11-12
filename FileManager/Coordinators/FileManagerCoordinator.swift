//
//  FileManagerCoordinator.swift
//  FileManager
//
//  Created by Алексей Голованов on 07.11.2023.
//

import UIKit

final class FileManagerCoordinator: Coordinatable {
    var navigationController: UINavigationController
    private var fileManagerService = FileManagerService.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        do {
            navigationController.navigationBar.prefersLargeTitles = true
            let documentsUrl = try fileManagerService.fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let viewController = FileManagerViewController(coordinator: self, fileManagerService: fileManagerService, title: "Документы", directory: documentsUrl)
            navigationController.tabBarItem = UITabBarItem(
                title: "Обзор",
                image: UIImage(systemName: "folder.fill"),
                tag: 0)
            navigationController.pushViewController(viewController, animated: true)
        } catch let error {
            print(error)
        }
    }
    
    func openFolder(directory: URL, name: String) {
        let folderUrl = directory.appendingPathComponent(name)
        let viewController = FileManagerViewController(coordinator: self, fileManagerService: fileManagerService, title: name, directory: folderUrl)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openNewFolder(viewController: UIViewController, completion: ((String) -> ())?) {
        var nameFolderTextField = UITextField()
        let alertController = UIAlertController(title: "Создать новую папку", message: "", preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Отмена", style: .cancel)
        let okBtn = UIAlertAction(title: "Создать", style: .default) { action in
            if let text = nameFolderTextField.text {
                let nameFolder = text.isEmpty ? "Новая папка" : text
                completion?(nameFolder)
            }
        }
        alertController.addAction(cancelBtn)
        alertController.addAction(okBtn)
        alertController.addTextField { textField in
            textField.placeholder = "Имя папки"
            nameFolderTextField = textField
        }
        navigationController.present(alertController, animated: true)
    }
    
}
