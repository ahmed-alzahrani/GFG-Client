//
//  SubscriptionsViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-12.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let searchBarValidator = SearchBarValidator()
    let sub = SubscriptionService()
    
    var subscriptions = [Subscription]()
    var filteredSubscriptions = [Subscription]()
    
    override func viewDidLoad() {
        sub.getSubscriptions(completed: setupTable)
    }
    
    private func setupTable(using: [Subscription]) {
        subscriptions = using
        filteredSubscriptions = using
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView?.rowHeight = 80
            self.tableView?.reloadData()
        })
        
    }
    
}

extension SubscriptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("perform segue with identifier the row of the subscription here")
    }
}

extension SubscriptionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSubscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath) as! SubscriptionCell
        
        cell.playerLabel.text = filteredSubscriptions[indexPath.row].name
        cell.teamLabel.text = filteredSubscriptions[indexPath.row].teamName
        cell.charityLabel.text = filteredSubscriptions[indexPath.row].charity
        cell.sinceLabel.text = filteredSubscriptions[indexPath.row].time
        return cell
        
    }
}

extension SubscriptionsViewController: UISearchBarDelegate {
    // generates the filtered list of products based on the user's search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSubscriptions = subscriptions.filter({ subscription -> Bool in
            guard let text = searchBar.text else { return false }
            if (text == "") {
                return true
            } else {
                return searchBarValidator.subscriptionValidator(subscription: subscription, text: text)
            }
        })
        self.tableView.reloadData()
    }
}
