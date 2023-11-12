//
//  SettingsTableViewCell.swift
//  FileManager
//
//  Created by Алексей Голованов on 10.11.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    static let id = "SettingsTableViewCell"
    private let settingsService = SettingsService.shared
    private var settingType: TypeSettings?
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingSwitch: UISwitch = {
        let swith = UISwitch()
        swith.translatesAutoresizingMaskIntoConstraints = false
        return swith
    }()
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        settingSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        guard let type = settingType else { return }
        let value = mySwitch.isOn
        settingsService.setSetting(setting: type, value: value)
    }
    
    private func addSubviews() {
        contentView.addSubview(settingLabel)
        contentView.addSubview(settingSwitch)
    }
    
    private func setupConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        settingSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }

    func configure(with setting: Setting) {
        settingType = setting.type
        settingLabel.text = setting.title
        settingSwitch.isOn = settingsService.getSetting(setting: setting.type)
    }
}
