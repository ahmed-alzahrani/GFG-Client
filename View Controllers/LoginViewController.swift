//
//  ViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-08.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let validator = UserValidator()
    let ups = UserProfileService()
    
    @IBAction func loginTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "login", sender: nil)
            })
        }
    }
    
    // user taps create account button
    @IBAction func createAccountTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if (validator.valid(email: email, password: password)) {
                Auth.auth().createUser(withEmail: email, password: password, completion: {user, error in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        return
                    }
                    if user != nil{
                        self.ups.addNewUser(documentId: user!.uid, email: user!.email!)
                    }
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if let fireBaseError = error {
                            print(fireBaseError.localizedDescription)
                            return
                        }
                    })
                    self.performSegue(withIdentifier: "login", sender: nil)
                })
            }
        }
    }
}

