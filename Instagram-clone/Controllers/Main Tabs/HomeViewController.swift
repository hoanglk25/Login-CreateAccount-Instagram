//
//  ViewController.swift
//  Instagram-clone
//
//  Created by Hoàng Đức on 14/11/2022.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Authenticated()
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("error")
        }
       
    }
    private func Authenticated() {
           // Check auth status
        if Auth.auth().currentUser == nil {
            // Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
        }
    }


}

