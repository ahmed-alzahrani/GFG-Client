//
//  UserProfileService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct UserProfileService {
    
    func addNewUser(documentId: String, email: String) {
        let db = Firestore.firestore()
        db.collection("users").document(documentId).setData([
            "name": " ",
            "email": email
            ])
    }
}
