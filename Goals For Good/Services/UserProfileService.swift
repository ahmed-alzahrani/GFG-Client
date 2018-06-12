//
//  UserProfileService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import FirebaseAuth

struct UserProfileService {
    
    typealias FinishedReq = (Bool) -> ()
    
    func checkSubscription(player: String, completed: @escaping FinishedReq) {
        if let user = Auth.auth().currentUser {
            let params = SubCheckParams(uid: user.uid, playerId: player)
            
            guard let uploadData = try? JSONEncoder().encode(params) else {
                return
            }
            
            var req = URLRequest(url: URL(string: "http://localhost:8080/amISubscribed")!)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: req, from: uploadData) { data, response, error in
                if let error = error {
                    print("error: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("server error")
                    return
                }
                
                if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                    
                    guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                        print("Not Containing JSON")
                        return
                    }
                    
                    guard let result = json["result"] as? Bool else {
                        print("couldn't get result from JSON")
                        return
                    }
                    
                    completed(result)
                }
            }
            task.resume()
        }
    }
    
    func addSubscription(toPlayer: String, playerName: String, toCharity: Charity, completed: @escaping FinishedReq) {
        if let user = Auth.auth().currentUser {
            let params = AddSubParams(uid: user.uid, playerId: toPlayer, name: playerName, charityName: toCharity.name!, charityId: toCharity.id!)
            
            guard let uploadData = try? JSONEncoder().encode(params) else {
                return
            }
            
            var req = URLRequest(url: URL(string: "http://localhost:8080/subscribe")!)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            let task = URLSession.shared.uploadTask(with: req, from: uploadData) { data, response, error in
                if let error = error {
                    print("errror: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("server error")
                    return
                }
                
                if let mimeType = response.mimeType,
                mimeType == "application/json",
                    let data = data {
                    
                    guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                        print("Not containing JSON")
                        return
                    }
                    
                    guard let result = json["result"] as? Bool else {
                        print("couldn't get result from JSON")
                        return
                    }
                    completed(result)
                }
            }
            task.resume()
        }
        // handle no current user here
    }
    
    func removeSubscription(player: String, completed: @escaping FinishedReq) {
        if let user = Auth.auth().currentUser {
            let params = RemoveSubParams(uid: user.uid, playerId: player)
            
            guard let uploadData = try? JSONEncoder().encode(params) else {
                return
            }
            
            var req = URLRequest(url: URL(string: "http://localhost:8080/unsubscribe")!)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: req, from: uploadData) { data, response, error in
                if let error = error {
                    print("error: \(error)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("server error")
                    return
                }
                
                if let mimeType = response.mimeType,
                mimeType == "application/json",
                    let data = data {
                    
                    guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                        print("Not containing JSON")
                        return
                    }
                    
                    guard let result = json["result"] as? Bool else {
                        print("couldn't get result from JSON")
                        return
                    }
                    completed(result)
                }
            }
            task.resume()
        }
    }
}
