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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let searchBarValidator = SearchBarValidator()
    
    var charities = [Charity]()
    var filteredCharities = [Charity]()
    
    override func viewDidLoad() {
        print("ViewDidLoad, need to call getMeCharities")
        NetworkingService.shared.getMeCharities(completed: setUpTable)
    }
    
    private func setUpTable(using: [Charity]) {
        charities = using
        filteredCharities = using
        tableView.rowHeight = 80
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue to the charity details page")
    }
}

extension CharitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("perform segue with identifier the row of the charity here")
    }
}

extension CharitiesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharityCell", for: indexPath) as! CharityCellViewController
        cell.nameLabel.text = filteredCharities[indexPath.row].name
        cell.idLabel.text = filteredCharities[indexPath.row].id
        cell.websiteLabel.text = filteredCharities[indexPath.row].website
        return cell
    }
}

extension CharitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharities = charities.filter({ charity -> Bool in
            guard let text = searchBar.text else { return false }
            if (text == "") {
                return true
            } else {
                return searchBarValidator.charityValidator(charity: charity, text: text)
            }
        })
        self.tableView.reloadData()
    }
}

