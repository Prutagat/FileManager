//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Алексей Голованов on 08.11.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    let coordinator: SettingsCoordinator
    var settings: [Setting] = makeSettings()
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        return tableView
    }()
    
    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.title = "Настройки"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(settingsTableView)
    }
    
    private func setupConstraints() {
        settingsTableView.snp.makeConstraints { make in make.top.leading.bottom.trailing.equalToSuperview() }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setting = settings[indexPath.row]
        
        if !setting.isSwitch {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            var content: UIListContentConfiguration = cell.defaultContentConfiguration()
            content.text = settings[indexPath.row].title
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.id,
            for: indexPath
        ) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: setting)
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        if setting.isSwitch { return }
        coordinator.changePassword()
    }
}
