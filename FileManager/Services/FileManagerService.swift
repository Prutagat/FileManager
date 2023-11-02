//
//  FileManagerService.swift
//  FileManager
//
//  Created by Алексей Голованов on 31.10.2023.
//

import Foundation

struct Content {
    let isDirectory: Bool
    let name: String
}

protocol FileManagerServiceProtocol {
    func contentsOfDirectory(directory: URL) -> [Content]
    func createDirectory(directory: URL, directoryName: String)
    func createFile(directory: URL, file: Data)
    func removeContent(directory: URL, fileName: String)
    func copyItem(at: URL, to: URL)
}

final class FileManagerService: FileManagerServiceProtocol {
    let fileManager: FileManager = FileManager.default
      
    func contentsOfDirectory(directory: URL) -> [Content] {
        var documents: [Content] = []
        do {
            let documentsUrl = try fileManager.contentsOfDirectory(atPath: directory.path)
            documentsUrl.forEach { document in
                var isDirectory: ObjCBool = false
                let documentUrl = directory.appendingPathComponent(document)
                fileManager.fileExists(atPath: documentUrl.path, isDirectory: &isDirectory)
                documents.append(Content(isDirectory: isDirectory.boolValue, name: document))
            }
        } catch let error {
            print(error)
        }
        return documents
    }
    func createDirectory(directory: URL, directoryName: String) {
        do {
            let newDirectoryUrl = directory.appendingPathComponent(directoryName)
            try fileManager.createDirectory(at: newDirectoryUrl, withIntermediateDirectories: false)
        } catch let error {
            print(error)
        }
    }
    func createFile(directory: URL, file: Data) {
        fileManager.createFile(atPath: directory.path, contents: file)
    }
    func removeContent(directory: URL, fileName: String) {
        do {
            let itemUrl = directory.appendingPathComponent(fileName)
            try fileManager.removeItem(at: itemUrl)
        } catch let error {
            print(error)
        }
    }
    func copyItem(at: URL, to: URL) {
        do {
            let imageName = at.lastPathComponent
            let newImageURL = to.appendingPathComponent(imageName)
            try fileManager.copyItem(at: at, to: newImageURL)
        } catch let error {
            print(error)
        }
    }
}
