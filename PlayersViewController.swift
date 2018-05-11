//
//  PlayersViewController.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-10.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import UIKit

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // these will help us keep the tableView properly populated in the event of a search
    var players = [DetailedPlayer]()
    var filteredPlayers = [DetailedPlayer]()
    
    override func viewDidLoad(){
        NetworkingService.shared.getMePlayers(completed: setUpTable)
    }
    
    private func setUpTable(using: [DetailedPlayer]) {
        players = using
        filteredPlayers = using
        tableView.rowHeight = 80
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "playerDetails",
        let PlayerDetailsViewController = segue.destination as? PlayerDetailsViewController,
        let player = sender as AnyObject as? DetailedPlayer
            else { return }
        PlayerDetailsViewController.player = player
    }
}

extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "playerDetails", sender: players[indexPath.row])
    }
}

extension PlayersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCellViewController
        cell.playerNameLabel.text = players[indexPath.row].common_name
        cell.positionLabel.text = players[indexPath.row].position
        cell.teamLabel.text = players[indexPath.row].team
        cell.leagueLabel.text! = "Premier League"
        print(cell.playerNameLabel.text!)
        return cell
    }
}


