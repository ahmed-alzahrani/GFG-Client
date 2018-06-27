//
//  MatchDetailsViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-23.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class MatchDetailsViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fixtureLabel: UILabel!
    @IBOutlet weak var matchDayLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    var match: Match?
    var events = [Event]()
    
    func setupMatch(matchToUse: Match) {
        match = matchToUse
        events = matchToUse.events
    }
    
    override func viewDidLoad() {
        if let thisMatch = match {
            navBar.topItem?.title = thisMatch.comp_id!
            fixtureLabel.text = thisMatch.localteam_name! + " v. " + thisMatch.visitorteam_name!
            matchDayLabel.text = thisMatch.season! + ": " + thisMatch.week!
            dateTimeLabel.text = thisMatch.formatted_date! + " " + thisMatch.time!
            venueLabel.text = thisMatch.venue
            tableView.rowHeight = 100
            tableView.reloadData()
        }
    }
}

extension MatchDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        cell.minuteLabel.text = event.minute
        cell.typeLabel.text = event.type
        cell.playerLabel.text = event.player
        cell.teamLabel.text = event.team
        cell.assistLabel.text = event.assist
        cell.resultLabel.text = event.result
        return cell
    }
}
