//
//  SubscriptionDetailsViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-16.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionDetailsViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var charity: UITextField!
    @IBOutlet weak var subscribedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var updateButton: UIButton!
    
    
    let sub = SubscriptionService()
    var subscription: Subscription?
    var charities: [Charity]?
    var selectedCharity: Charity?
    var matches = [Match]()
    var filteredMatches = [Match]()
    
    
    @IBAction func unsubscribeTapped(_ sender: UIButton) {
        if let toRemove = subscription {
            sub.removeSubscription(player: toRemove.id!, completed: handleUnsubscribe)
        }
    }
    
    @IBAction func updateSubscriptionTapped(_ sender: UIButton) {
        if let toRemove = subscription, let newCharity = selectedCharity {
            sub.updateSubscription(player: toRemove.id!, charity: newCharity, completed: handleUpdate)
        }
    }
    
    
    private func handleUnsubscribe(result: Bool) {
        if (result) {
            performSegue(withIdentifier: "backToSubscriptions", sender: nil)
        } else {
            print("the unsubscribe process was unsuccessful")
        }
        
    }
    
    private func handleUpdate(result: Bool) {
        if (result) {
            subscription?.charity = selectedCharity?.name
            subscription?.charityId = selectedCharity?.id
            
            print("ok lets look at the subscription now... ")
            print(subscription?.charity! ?? "error")
            print(subscription?.charityId! ?? "error")
        } else {
            print("the subscription update was unsuccessful")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = subscription?.name
        subscribedLabel.text = subscription?.time
        charity.text = subscription?.charity!
        DataService.shared.getCharities(completed: assignCharities)
        createCharityPicker()
        createToolbar()
        DataService.shared.getPlayerMatches(completed: setupTable, withId: (subscription?.team)!)
    }
    
    private func setupTable(using: [Match]) {
        matches = using
        filteredMatches = using
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView?.rowHeight = 105
            self.tableView?.reloadData()
        })
    }
    
    private func createCharityPicker() {
        let charityPicker = UIPickerView()
        charityPicker.delegate = self
        charity.inputView = charityPicker
    }
    
    private func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SubscriptionDetailsViewController.dismissKeyboard))
        
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
    
    func setupSubscription(using: Subscription) {
        subscription = using
        DispatchQueue.main.async(execute: {() -> Void in
            // set up the UI elements here
        })
    }
}

extension SubscriptionDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("perform segue with identifier the row of the match here")
    }
}

extension SubscriptionDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchCell
        
        let fixture = filteredMatches[indexPath.row].localteam_name! + " v. " + filteredMatches[indexPath.row].visitorteam_name!
        cell.fixtureLabel.text = fixture
        cell.competitionLabel.text = filteredMatches[indexPath.row].comp_id
        cell.dateLabel.text = filteredMatches[indexPath.row].formatted_date
        cell.venueLabel.text = filteredMatches[indexPath.row].venue
        return cell
    }
}

extension SubscriptionDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        updateButton.isUserInteractionEnabled = true
        selectedCharity = charities![row]
        charity.text = selectedCharity?.name!
    }
}
