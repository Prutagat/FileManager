//
//  CustomTextField.swift
//  FileManager
//
//  Created by Алексей Голованов on 06.11.2023.
//

import UIKit

final class CustomTextField: UITextField {
    typealias Action = () -> Void
    var textFieldAction: Action
    
    init(placeholderText: String, text: String = "", isSecureTextEntry: Bool = false, action: @escaping Action) {
        textFieldAction = action
        super.init(frame: .zero)
        textFieldSetup(placeholderText: placeholderText, textDefault: text, isSecure: isSecureTextEntry)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editingChanged() {
        textFieldAction()
    }
    
    private func textFieldSetup(placeholderText: String, textDefault: String, isSecure: Bool) {
        backgroundColor = .systemGray6
        clipsToBounds = true
        borderStyle = UITextField.BorderStyle.roundedRect
        autocapitalizationType = .none
        tintColor = UIColor(named: "new_color_set")
        translatesAutoresizingMaskIntoConstraints = false
        autocorrectionType = UITextAutocorrectionType.no
        keyboardType = UIKeyboardType.default
        returnKeyType = UIReturnKeyType.done
        clearButtonMode = UITextField.ViewMode.whileEditing
        contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        placeholder = placeholderText
        isSecureTextEntry = isSecure
        text = textDefault
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
}
