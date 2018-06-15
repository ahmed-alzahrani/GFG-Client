//
//  MatchesViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-14.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class MatchesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let searchBarValidator = SearchBarValidator()
    
    var matches = [Match]()
    var filteredMatches = [Match]()
    
    override func viewDidLoad() {
        DataService.shared.getMatches(completed: setupTable)
    }
    
    private func setupTable(using: [Match]) {
        matches = using
        filteredMatches = using
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView?.rowHeight = 80
            self.tableView?.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue to the charity details page")
    }
}

extension MatchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("perform segue with identifier the row of the match here")
    }
}

extension MatchesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchCell
        cell.homeTeamLabel.text = filteredMatches[indexPath.row].localteam_name
        cell.awayTeamLabel.text = filteredMatches[indexPath.row].visitorteam_name
        cell.competitionLabel.text = filteredMatches[indexPath.row].comp_id
        cell.dateLabel.text = filteredMatches[indexPath.row].formatted_date
        cell.venueLabel.text = filteredMatches[indexPath.row].venue
        return cell
    }
}

// add searchBar extension in here
