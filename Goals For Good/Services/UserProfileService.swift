//
//  UserProfileService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth

struct UserProfileService {

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

    // should this take in a UIVC so its more general, or a LGVC subclass
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

    // checkSubscription POST req needs to be changed to be properly async to actually work, returns bool and not result
    func checkSubscription(toPlayer: String) -> Bool {
        var bool = false
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let parameters: Parameters = [
                "uid": uid,
                "playerId": toPlayer
            ]
            let url = "http://localhost:8080/amISubscribed"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

                switch response.result {
                case .failure(let error):
                    // handle some error
                    print(error)

                case .success(let data):
                    guard let json = data as? [String: AnyObject] else {
                        print("failed to get expected response from webserver")
                        return
                    }

                    guard let result = json["result"] as? Bool else {
                        print("failed to get result value from the server")
                        return
                    }
                    bool = result
                }
            }
        }
        // if this executes it means for whatever reason there isn't a logged in user, this will need to be handled but for now return false
        // for some reason checkSubscription asynch doesnt block
        return bool
    }

    // add subscription call WORKS, but will need to be reworked to be properly async like the rest of the calls
    func addSubscription(toPlayer: String, playerName: String, toCharity: Charity?) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            var charityName = ""
            var charityId = ""
            if let charity = toCharity {
                charityName = charity.name!
                charityId = charity.id!
            }
            let parameters: Parameters = [
                "uid": uid,
                "playerId": toPlayer,
                "name": playerName,
                "charityName": charityName,
                "charityId": charityId
            ]
            let url = "http://localhost:8080/subscribe"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .failure(let error):
                    // handle an error here
                    print(error)

                case .success(let data):
                    guard let json = data as? [String: AnyObject] else {
                        print("failed to get result object from the server")
                        return
                    }

                    guard (json["result"] as? Bool) != nil else {
                        print("failed to get result value from the server")
                        return
                    }
                }
            }
        }
        // user couldn't be authorized, handle that here
    }

    // remove subscription call WORKS, but will need to be reworked to be properly async like the rest of the calls
    func removeSubscription(toPlayer: String) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            print(uid)
            let parameters: Parameters = [
                "uid": uid,
                "playerId": toPlayer
            ]
            let url = "http://localhost:8080/unsubscribe"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .failure(let error) :
                    // handle error here
                    print(error)

                case .success(let data):
                    guard let json = data as? [String: AnyObject] else {
                        print("failed to get result object from the server")
                        return
                    }

                    guard (json["result"] as? Bool) != nil else {
                        print("failed to get result value from the server")
                        return
                    }

                }
            }
        }
        // user couldn't be authorized, handle that here
    }
}
