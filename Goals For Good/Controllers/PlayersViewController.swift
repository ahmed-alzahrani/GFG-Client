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
    var players = [Player]()
    var filteredPlayers = [Player]()

    override func viewDidLoad(){
        print("viewDidLoad, im calling getMePlayers")
        NetworkingService.shared.getMePlayers(completed: setUpTable)
    }

    private func setUpTable(using: [Player]) {
        players = using
        filteredPlayers = using
        tableView.rowHeight = 80
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "playerDetails",
        let PlayerDetailsViewController = segue.destination as? PlayerDetailsViewController,
        let player = sender as AnyObject as? Player
            else { return }
        let detailedPlayer = NetworkingService.shared.getPlayer(withID: player.id!)
        PlayerDetailsViewController.player = detailedPlayer
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
        cell.playerNameLabel.text = players[indexPath.row].name
        cell.positionLabel.text = players[indexPath.row].position
        cell.teamLabel.text = players[indexPath.row].team
        cell.leagueLabel.text = players[indexPath.row].league
        return cell
    }
}
