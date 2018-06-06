//
//  NetworkingService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingService {

    typealias FinishedPlayers = ([Player]) -> ()
    typealias FinishedCharities = ([Charity]) -> ()
    static let shared = NetworkingService()
    private init() {}
    
    // Public API
    func getMePlayers(completed: FinishedPlayers) {
        let players = getPlayers()
        completed(players)
    }
    
    func getPlayer(withID: String) -> DetailedPlayer? {
        let player = getPlayerDetails(with: withID)
        return player
    }
    
    
    func getMeCharities(completed: FinishedCharities) {
        print("im inside get me charities... about to make a call to get the charities")
        let charities = getCharities()
        completed(charities)
    }
    
    // Private Implementation
    private func getPlayers() -> [Player]{
        var count = 0
        var players = [Player]()
        // we need to return the standings of each competition to access each team
        let urlString = "http://localhost:8080/players"
        print("querying... " + urlString)
        guard let url = URL(string: urlString) else { return [Player]()}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("failed getting data")
                return }
            do {
                players += try
                    JSONDecoder().decode([Player].self, from: data)
                count += 1
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()

        // we can hardCode the count in this func to 1 bc we're only making and waiting on 1 async call
         while (count < 1){
            continue
        }
        print(players.count)
        print("returning the players")
        return players
    }

    private func getPlayerDetails(with: String) -> DetailedPlayer? {
        var count = 0
        var player: DetailedPlayer?
        let urlString = "http://localhost:8080/player/" + with
        guard let url = URL(string: urlString) else { return nil }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("failed getting data")
                return }
            do {
                player = try
                    JSONDecoder().decode(DetailedPlayer.self, from: data)
                count += 1
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()
        while (count < 1) {
            continue
        }
        return player
    }
    
    private func getCharities() -> [Charity] {
       var count = 0
        var charities = [Charity]()
        let urlString = "http://localhost:8080/charities"
        guard let url = URL(string: urlString) else { return [Charity]() }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("failed getting data")
                return }
            do {
                charities += try
                    JSONDecoder().decode([Charity].self, from: data)
                count += 1
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()
        
        while (count < 1) {
            continue
        }
        print(charities.count)
        print("returning the charities")
        return charities
    }
}
