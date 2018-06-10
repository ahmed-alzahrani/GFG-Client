//
//  ProfileViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBAction func logoutTapped(_ sender: Any) {
        let ups = UserProfileService()
        ups.logout()
        self.performSegue(withIdentifier: "logout", sender: nil)

    }

    @IBAction func Subscriptions(_ sender: UIButton) {
        self.performSegue(withIdentifier: "subscriptions", sender: nil)
    }
}
