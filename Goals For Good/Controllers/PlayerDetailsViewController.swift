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
        initializeLabels()
        NetworkingService.shared.getMeCharities(completed: assignCharities)

        if ups.checkSubscription(toPlayer: (player?.id)!) {
            print("youre not subscribed to this player")
            unsubscribeButton.isHidden = false
            subscribeButton.isHidden = true
        } else {
            print("youre subscribed to this player already")
            subscribeButton.isHidden = false
            unsubscribeButton.isHidden = true
        }
        subscribeButton.isUserInteractionEnabled = false
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

    private func initializeLabels() {
        nameLabel.text = player?.name
        nationalityLabel.text = player?.nationality
        ageLabel.text = player?.age
        birthDateLabel.text = player?.birthdate
        positionLabel.text = player?.position
        birthPlaceLabel.text = player?.birthplace
        heightLabel.text = player?.height
        weightLabel.text = player?.weight
    }

    private func assignCharities(using: [Charity]) {
        charities = using
    }

    @IBAction func subscribeButton(_ sender: UIButton) {
        if let playerToSubscribe = player {
            ups.addSubscription(toPlayer: playerToSubscribe.id!, playerName: playerToSubscribe.name!, toCharity: selectedCharity)
        }
        unsubscribeButton.isHidden = false
        subscribeButton.isHidden = true
    }

    @IBAction func unsubScribeButton(_ sender: UIButton) {
        if let playerToUnsubscribe = player {
            ups.removeSubscription(toPlayer: playerToUnsubscribe.id!)
        }
        subscribeButton.isHidden = false
        unsubscribeButton.isHidden = true
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
