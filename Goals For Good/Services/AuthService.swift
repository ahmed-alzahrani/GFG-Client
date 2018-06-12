//
//  AuthService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-11.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth

class AuthService {
    
    func createUser(email: String, password: String, view: UIViewController) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {user, error in
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                return
            }
            if user != nil{
                self.addUser(documentId: user!.uid, email: user!.email!)
            }
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                if let fireBaseError = error {
                    print(fireBaseError.localizedDescription)
                    return
                }
            })
            view.performSegue(withIdentifier: "login", sender: nil)
        })
    }
    
    private func addUser(documentId: String, email: String) {
        let parameters: Parameters = [
            "uid": documentId,
            "email": email
        ]
        let url = "http://localhost:8080/addUser"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
        }
    }
    
    func loginUser(email: String, password: String, view: UIViewController) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                return
            }
            view.performSegue(withIdentifier: "login", sender: nil)
        })
    }
    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let err = error {
                print(err)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let err {
            print("Failed to sign out with error", err)
        }
    }
}
