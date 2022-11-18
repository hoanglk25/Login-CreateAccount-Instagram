//
//  LoginViewController.swift
//  Instagram-clone
//
//  Created by Hoàng Đức on 14/11/2022.
//
import SafariServices
import UIKit

class LoginViewController: UIViewController {
    private let usernameEmailTextField: UITextField = {
       let field = UITextField()
        field.placeholder = "Username or Email..."
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
       return button
    }()
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Term of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
       return button
    }()
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
       return button
    }()
    private let headerView: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        let imageView = UIImageView(image: UIImage(named: "gradient"))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return view
        
    }()
    private let CreataccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Creat an new Account", for: .normal)
       return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
        usernameEmailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        CreataccountButton.addTarget(self, action: #selector(didTapCreatAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = .init(x: 0, y: view.top-34, width: view.width, height: view.height/3)
        usernameEmailTextField.frame = .init(x: 25, y: headerView.top+headerView.height+20, width: view.width-50, height: 50)
        passwordTextField.frame = .init(x: 25, y: usernameEmailTextField.top+60 , width: view.width-50, height: 50)
        loginButton.frame = .init(x: 25, y: passwordTextField.top + 65, width: view.width-50, height: 50)
        CreataccountButton.frame = .init(x: 25, y: loginButton.top + 60, width: view.width-50, height: 50)
        termsButton.frame = .init(x: 25, y: view.height - 100, width: view.width-50, height: 30)
        privacyButton.frame = .init(x: 25, y: view.height-130, width: view.width-50, height: 30)
        
        
        
        
        configureHeaderView()
        
    }
    
    func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "logotext"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = .init(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
        
    }
    
    func addSubviews() {
        view.addSubview(usernameEmailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        view.addSubview(headerView)
        view.addSubview(CreataccountButton)
    }
    @objc private func didTapLoginButton() {
        usernameEmailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let usernameEmail = usernameEmailTextField.text, !usernameEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            //email
            email = usernameEmail
        } else {
            // username
            username = usernameEmail
        }
    
        // login
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            
            DispatchQueue.main.async {
               
                if success {
                    // user log in
                    
                    
                } else {
                    // error
                    let alert = UIAlertController(title: "Log In Error", message: "Unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }
                
            }
           
           
        }
       
    }
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://privacycenter.instagram.com/policy") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    @objc private func didTapCreatAccountButton() {
        let vc = RegistionViewController()
        vc.title = "Creat an Account"
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }

    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailTextField{
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
}
