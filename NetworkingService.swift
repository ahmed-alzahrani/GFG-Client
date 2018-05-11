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
    
    typealias FinishedDownload = ([DetailedPlayer]) -> ()
    let configuration = config()
    static let shared = NetworkingService()
    private init() {}
    
    private func getTeams() -> [Team]{
        var count = 0
        var teams = [Team]()
        // we need to return the standings of each competition to access each team
        for id in configuration.competitionIds {
            let jsonUrlString = configuration.baseUrl + "standings/" + id + "?Authorization=" + configuration.apiKey
            guard let url = URL(string: jsonUrlString) else { return [Team]()}
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    teams += try
                        JSONDecoder().decode([Team].self, from: data)
                    count += 1
                } catch let jsonErr {
                    print("error serializing JSON", jsonErr)
                }
            }.resume()
        }
        // we can hardCode the count in this func to 17 bc we KNOW we only have access to 17 competitions through api.football-api.com
        while (count < configuration.competitionIds.count){
            continue
        }
        // because we continue until our count hits 17, we wont print and return too early before all the async calls are made
        print(teams.count)
        print("returning the teams (not paged)")
        return teams
    }
    
    private func getPagedTeams(fromTeams: [Team]) -> [PagedTeam] {
        var count = 0
        var pagedTeams = [PagedTeam]()
        for team in fromTeams {
          //  print("trying to get a new paged team...")
            let jsonUrlString = configuration.baseUrl + "team/" + team.team_id! + "?Authorization=" + configuration.apiKey
          //  print("generated my URL string")
            guard let url = URL(string: jsonUrlString) else { return [PagedTeam]()}
        //    print("made my URL")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
               // print("got my data")
                do {
                    let pagedTeam =  try
                        JSONDecoder().decode(PagedTeam.self, from: data)
                 //   print("decoded!")
                    pagedTeams.append(pagedTeam)
               //     print("count is += 1")
                    count += 1
                    print(count)
                } catch let jsonErr {
                    print("error serializing JSON", jsonErr)
                }
            }.resume()
        }
        while (count < fromTeams.count) {
            continue
        }
        print(pagedTeams.count)
       // print("returning paged teams")
        return pagedTeams
    }
    
    private func getPlayers(fromTeams: [PagedTeam]) -> [DetailedPlayer] {
        var count = 0
        var players = [DetailedPlayer]()
        for team in fromTeams{
            if (team.team_id! == "9406") {
                for player in team.squad! {
                    print("tryna add a new player!")
                    let jsonUrlString = configuration.baseUrl + "player/" + player.id! + "?Authorization=" + configuration.apiKey
                    guard let url = URL(string: jsonUrlString) else { return [DetailedPlayer]()}
                    print("made my URL")
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        print("got my data")
                        do {
                            let player =  try
                                JSONDecoder().decode(DetailedPlayer.self, from: data)
                            print("decoded!")
                            players.append(player)
                            print("count is += 1")
                            count += 1
                            print(count)
                        } catch let jsonErr {
                            print("error serializing JSON", jsonErr)
                        }
                        }.resume()
                }
                
            }
        }
        while (count < 28) {
            continue
        }
        print(players.count)
        print("returning players")
        return players
    }
    
    func getMePlayers(completed: FinishedDownload) {
        let teams = getTeams()
        let pagedTeams = getPagedTeams(fromTeams: teams)
        print("calling get players!")
        let players = getPlayers(fromTeams: pagedTeams)
        completed(players)
    }
}
    

