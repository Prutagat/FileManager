//
//  SettingsModel.swift
//  FileManager
//
//  Created by Алексей Голованов on 10.11.2023.
//

import UIKit

struct Setting {
    let isSwitch: Bool
    let type: TypeSettings
    let title: String
}

func makeSettings() -> [Setting] {
    [
        Setting(isSwitch: true, type: .sorting, title: "Cортировка"),
        Setting(isSwitch: true, type: .showPhotoSize, title: "Показывать размер фотографии"),
        Setting(isSwitch: false, type: .changePassword, title: "Поменять пароль")
    ]
}
