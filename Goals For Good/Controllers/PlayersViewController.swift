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
    let searchBarValidator = SearchBarValidator()

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
        cell.playerNameLabel.text = filteredPlayers[indexPath.row].name
        cell.positionLabel.text = filteredPlayers[indexPath.row].position
        cell.teamLabel.text = filteredPlayers[indexPath.row].team
        cell.leagueLabel.text = filteredPlayers[indexPath.row].league
        return cell
    }
}

extension PlayersViewController: UISearchBarDelegate {
    
    // generates the filtered list of products based on the user's search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlayers = players.filter({ player -> Bool in
            guard let text = searchBar.text else { return false }
            if (text == "") {
                return true
            } else {
                return searchBarValidator.searchValidator(player: player, text: text)
            }
        })
        self.tableView.reloadData()
    }
}

