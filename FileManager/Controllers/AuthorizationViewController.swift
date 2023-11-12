//
//  AuthorizationViewController.swift
//  FileManager
//
//  Created by Алексей Голованов on 06.11.2023.
//

import UIKit
import SnapKit

final class AuthorizationViewController: UIViewController {
    
    // MARK: - parametrs
    
    let coordinator: AppCoordinator
    var userPassword = ""
    let keychainService = KeychainService.shared
    
    private lazy var passwordTextField = CustomTextField(placeholderText: "Пароль", text: "1234", isSecureTextEntry: true) { [weak self] in
        self?.passwordChanged()
    }
    private lazy var authorizationButton = CustomButton(title: "Введите пароль") { [weak self] in
        self?.authorization()
    }
    
    // MARK: - initialization
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.title = "Авторизация"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        getUserPassword()
        passwordChanged()
    }
    
    // MARK: - functions
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(passwordTextField)
        view.addSubview(authorizationButton)
    }
    
    private func setupConstraints() {
        passwordTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        authorizationButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func getUserPassword() {
        userPassword = keychainService.getPassword()
        if userPassword.isEmpty { authorizationButton.setTitle("Создать пароль", for: .normal) }
    }
    
    private func passwordIsCorrect(password: String) -> Bool {
        var isCorrect = password.count >= 4
        if isCorrect {
            if password != userPassword && !userPassword.isEmpty {
                isCorrect = false
                keychainService.deletePassword()
                coordinator.presentAlert(title: "Ошибка", message: "Пароль не совпадает с ранее заданным, пароль сброшен")
                authorizationButton.setTitle("Создать пароль", for: .normal)
            }
        } else {
            coordinator.presentAlert(title: "Ошибка", message: "Минимальная длина пароля 4 символа")
        }
        return isCorrect
    }
    
    private func passwordChanged() {
        authorizationButton.isEnabled = !passwordTextField.text!.isEmpty
    }
    
    private func authorization() {
        let password = passwordTextField.text!
        if !passwordIsCorrect(password: password) {
            userPassword = ""
            passwordTextField.text = ""
            return
        }
        if userPassword.isEmpty {
            userPassword = password
            passwordTextField.text = ""
            authorizationButton.setTitle("Повторите пароль", for: .normal)
        } else if password == userPassword {
            keychainService.setPassword(password: password)
            if title != "Авторизация" { return }
            coordinator.showTabBarController()
        }
    }
}
