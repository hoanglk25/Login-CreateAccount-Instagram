//
//  RegistionViewController.swift
//  Instagram-clone
//
//  Created by Hoàng Đức on 14/11/2022.
//

import UIKit

class RegistionViewController: UIViewController {
    private let usernameTextField: UITextField = {
       let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.gray.cgColor
        
        return field
    }()
    private let emailTextField: UITextField = {
       let field = UITextField()
        field.placeholder = "Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.gray.cgColor
        
        return field
    }()
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 10
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.gray.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
       return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(registerButton)
        view.addSubview(passwordTextField)
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameTextField.frame = .init(x: 25, y: view.top+100, width: view.width - 50, height: 50)
        emailTextField.frame = .init(x: 25, y: usernameTextField.top+60, width: view.width - 50, height: 50)
        passwordTextField.frame = .init(x: 25, y: emailTextField.top+60, width: view.width - 50, height: 50)
        registerButton.frame = .init(x: 25, y: passwordTextField.top+70, width: view.width - 50, height: 50)
    }
    
    @objc func didTapRegister() {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        
        guard let email = emailTextField.text, !email.isEmpty,
              let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registed in
            DispatchQueue.main.async {
                if registed {
                    
                } else {
                    
                }
            }
            
        }
        dismiss(animated: true)
//        let alert = UIAlertController(title: "Creat an Acount", message: "Successfull", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
    }
  

}
extension RegistionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        return true
    }
}
