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
    
    typealias FinishedDownload = ([Player]) -> ()
    static let shared = NetworkingService()
    private init() {}
    
    
    private func getPlayers(playerCount: Int) -> [Player]{
        var count = 0
        var players = [Player]()
        // we need to return the standings of each competition to access each team
        let urlString = "http://localhost:8080/allPlayers"
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
                print("count is... \(count)")
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()
        
        // we can hardCode the count in this func to 17 bc we KNOW we only have access to 17 competitions through api.football-api.com
        while (count < 1){
            continue
        }
        // because we continue until our count hits 17, we wont print and return too early before all the async calls are made
        print(players.count)
        print("returning the players")
        return players
    }
    
    func getMePlayers(completed: FinishedDownload) {
        print("calling getPlayers!")
        let players = getPlayers(playerCount: 580)
        print("calling get players!")
        completed(players)
    }
}
    

