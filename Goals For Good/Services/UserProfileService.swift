//
//  UserProfileService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import Alamofire


// deprecated... maybe? should probably migrate viewController code into here
import FirebaseFirestore
import FirebaseAuth

struct UserProfileService {

    func addUser(documentId: String, email: String) {
        let parameters: Parameters = [
            "uid": documentId,
            "email": email
        ]
        let url = "http://localhost:8080/addUser"
        print("just made params and url")
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            
        }
    }
    
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
    
    func addSubscription(toPlayer: String, playerName: String, toCharity: String) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let parameters: Parameters = [
                "uid": uid,
                "playerId": toPlayer,
                "name": playerName,
                "charity": toCharity
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
