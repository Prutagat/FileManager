//
//  KeychainService.swift
//  FileManager
//
//  Created by Алексей Голованов on 06.11.2023.
//

import UIKit
import KeychainSwift

enum KeychainError: Error {
    case isEmpty
    case notCorrect
}

protocol KeychainServiceProtocol {
    func getPassword(key: String) -> String
    func setPassword(password: String, key: String)
    func deletePassword(key: String)
}

final class KeychainService: KeychainServiceProtocol  {
    static let shared = KeychainService()
    private let keychain = KeychainSwift()
    
    private init() {}
    
    func getPassword(key: String = "userPassword") -> String {
        if let password = keychain.get(key) {
            return password
        } else {
            return ""
        }
    }
    
    func setPassword(password: String, key: String = "userPassword") {
        keychain.set(password, forKey: key)
    }
    
    func deletePassword(key: String = "userPassword") {
        keychain.delete(key)
    }
}

extension KeychainService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
