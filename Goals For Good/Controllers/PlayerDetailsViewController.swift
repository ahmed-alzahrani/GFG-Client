//
//  PlayerDetailsViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-11.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class PlayerDetailsViewController: UIViewController {
    let ups = UserProfileService()
    
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var unsubscribeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var player: DetailedPlayer?
    
    @IBAction func subscribeButton(_ sender: UIButton) {
        if let playerToSubscribe = player {
            ups.subscribeToPlayer(toPlayer: playerToSubscribe.id!, playerName: playerToSubscribe.name!)
        }
        unsubscribeButton.isHidden = false
        subscribeButton.isHidden = true
    }
    
    @IBAction func unsubScribeButton(_ sender: UIButton) {
        if let playerToUnsubscribe = player {
            ups.unsubscribeToPlayer(toPlayer: playerToUnsubscribe.id!)
        }
        subscribeButton.isHidden = false
        unsubscribeButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = player?.name
        nationalityLabel.text = player?.nationality
        ageLabel.text = player?.age
        birthDateLabel.text = player?.birthdate
        positionLabel.text = player?.position
        birthPlaceLabel.text = player?.birthplace
        heightLabel.text = player?.height
        weightLabel.text = player?.weight
        
        if ups.amISubscribed(toPlayer: (player?.id)!) {
            unsubscribeButton.isHidden = false
            subscribeButton.isHidden = true
        } else {
            subscribeButton.isHidden = false
            unsubscribeButton.isHidden = true
        }
    }
    
}
