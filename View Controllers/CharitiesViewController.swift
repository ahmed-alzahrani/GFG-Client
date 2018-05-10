//
//  CharitiesViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class CharitiesViewController: UIViewController {
    
    @IBAction func HitMeTapped(_ sender: UIButton) {
        print("About to call Networking Services getTeams()!")
        NetworkingService.shared.getTeams()
        
    }
}
