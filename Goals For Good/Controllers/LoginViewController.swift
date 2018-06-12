//
//  ViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-08.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let auth = AuthService()
    let validator = UserValidator()
    let ups = UserProfileService()

    @IBAction func loginTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            auth.loginUser(email: email, password: password, view: self)
        }
    }

    // user taps create account button
    @IBAction func createAccountTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if (validator.valid(email: email, password: password)) {
                auth.createUser(email: email, password: password, view: self)
            }
        }
    }
    @IBAction func forgotPassword(_ sender: UIButton) {
        if let email = emailTextField.text {
            print("the user has typed in the following email address and selected forgot password")
            auth.sendPasswordReset(email: email)
            
        }
    }
}
