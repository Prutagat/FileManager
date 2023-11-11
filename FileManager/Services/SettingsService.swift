//
//  SettingsService.swift
//  FileManager
//
//  Created by Алексей Голованов on 10.11.2023.
//

import UIKit

enum TypeSettings: String {
    case sorting = "sorting"
    case showPhotoSize = "showPhotoSize"
    case changePassword = "changePassword"
}

protocol SettingsServiceProtocol {
    func getSetting(setting: TypeSettings) -> Bool
    func setSetting(setting: TypeSettings, value: Bool)
}

final class SettingsService: SettingsServiceProtocol {
    static let shared = SettingsService()
    
    let defaults = UserDefaults.standard
    
    private init() {}
    
    func getSetting(setting: TypeSettings) -> Bool {
        return defaults.bool(forKey: setting.rawValue)
    }
    func setSetting(setting: TypeSettings, value: Bool) {
        defaults.setValue(value, forKey: setting.rawValue)
    }
}

extension SettingsService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
