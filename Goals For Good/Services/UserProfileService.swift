//
//  UserProfileService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct UserProfileService {
    
    func addNewUser(documentId: String, email: String) {
        let db = Firestore.firestore()
        db.collection("users").document(documentId).setData([
            "name": " ",
            "email": email
            ])
    }
    
    func amISubscribed(toPlayer: String) -> Bool {
        var uid: String
        var flag = 0
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            uid = user.uid
        } else {
            uid = " "
        }
        let docRef = db.collection("users").document(uid).collection("subscriptions").document(toPlayer)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Subscription DOES exist!")
                flag = 1
            } else {
                print("Subscription does NOT exist")
            }
        }
        print("about to return from amISubscribed")
        return (flag == 1)
    }
    
    func subscribeToPlayer(toPlayer: String, playerName: String) {
        var uid: String
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            uid = user.uid
        } else {
            uid = " "
        }
        
        if (uid != " ") {
            db.collection("users").document(uid).collection("subscriptions").document(toPlayer).setData([
                "name": playerName
                ])
        }
    }
    
    func unsubscribeToPlayer(toPlayer: String) {
        var uid: String
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            uid = user.uid
        } else {
            uid = " "
        }
        
        if (uid != " ") {
            db.collection("users").document(uid).collection("subscriptions").document(toPlayer).delete() { err in
                if err != nil {
                    print("Error removing document!")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        
    }
}
