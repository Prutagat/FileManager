//
//  ImagePicker.swift
//  FileManager
//
//  Created by Алексей Голованов on 02.11.2023.
//

import UIKit

final class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePickerController: UIImagePickerController?
    var completion: ((URL) -> ())?
    
    func show(coordinator: AppCoordinator, completion: ((URL) -> ())?) {
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController!.delegate = self
        coordinator.presentImagePicker(imagePickerController: imagePickerController!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL {
            self.completion?(imageURL)
        }
        picker.dismiss(animated: true)
    }
}
