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
    let sub = SubscriptionService()

    // outlets
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var unsubscribeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var charity: UITextField!

    var player: DetailedPlayer?
    var charities: [Charity]?
    var selectedCharity: Charity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.shared.getCharities(completed: assignCharities)
        createCharityPicker()
        createToolbar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        tabBarController.selectedIndex = 1
    }

    private func createCharityPicker() {
        let charityPicker = UIPickerView()
        charityPicker.delegate = self
        charity.inputView = charityPicker
    }

    private func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PlayerDetailsViewController.dismissKeyboard))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        charity.inputAccessoryView = toolBar
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func assignCharities(using: [Charity]) {
        charities = using
    }
 
    func setupPlayer(using: DetailedPlayer) {
        player = using
        DispatchQueue.main.async(execute: {() -> Void in
            self.subscribeButton.isUserInteractionEnabled = false
            self.nameLabel.text = self.player?.name
            self.nationalityLabel.text = self.player?.nationality
            self.ageLabel.text = self.player?.age
            self.birthDateLabel.text = self.player?.birthdate
            self.positionLabel.text = self.player?.position
            self.birthPlaceLabel.text = self.player?.birthplace
            self.heightLabel.text = self.player?.height
            self.weightLabel.text = self.player?.weight
            
            if let id = self.player?.id {
                self.sub.checkSubscription(player: id, completed: self.setupSubButtons)
            }
        })
    }
    
    func setupSubButtons(subbed: Bool) {
        DispatchQueue.main.async(execute: {() -> Void in
            if (subbed) {
                self.subscribeButton.isHidden = true
                self.unsubscribeButton.isHidden = false
            } else {
                self.subscribeButton.isHidden = false
                self.unsubscribeButton.isHidden = true
            }
        })
    }

    @IBAction func subscribeButton(_ sender: UIButton) {
        if let playerToSubscribe = player, let charityToSubscribe = selectedCharity {
            sub.addSubscription(toPlayer: playerToSubscribe.id!, playerName: playerToSubscribe.name!, toCharity: charityToSubscribe, completed: subscribeComplete)
        }
    }
    
    private func subscribeComplete(success: Bool) {
        if (success) {
            DispatchQueue.main.async(execute: {() -> Void in
                self.unsubscribeButton.isHidden = false
                self.subscribeButton.isHidden = true
            })
        }
    }

    @IBAction func unsubScribeButton(_ sender: UIButton) {
        if let playerToUnsubscribe = player {
            sub.removeSubscription(player: playerToUnsubscribe.id!, completed: unsubscribeComplete)
        }
    }
    
    private func unsubscribeComplete(success: Bool) {
        if (success) {
            DispatchQueue.main.async(execute: {() -> Void in
                self.subscribeButton.isHidden = false
                self.unsubscribeButton.isHidden = true
            })
        }
    }
}

extension PlayerDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (charities?.count)!
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return charities![row].name!
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subscribeButton.isUserInteractionEnabled = true
        selectedCharity = charities![row]
        charity.text = selectedCharity!.name!
    }

}
