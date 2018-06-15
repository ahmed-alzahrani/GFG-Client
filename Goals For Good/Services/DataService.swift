//
//  NetworkingService.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import FirebaseAuth

struct DataService {

    typealias FinishedPlayers = ([Player]) -> ()
    typealias FinishedCharities = ([Charity]) -> ()
    typealias FinishedPlayer = (DetailedPlayer) -> ()
    typealias FinishedMatches = ([Match]) -> ()
    static let shared = DataService()
    private init() {}

    private func getReq(with: String) -> URLRequest {
        return URLRequest(url: URL(string: with)!)
    }

    func getPlayers(completed: @escaping FinishedPlayers) {
        guard let url = URL(string: "http://localhost:8080/players") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("failed getting data")
                return }
            do {
                let players = try JSONDecoder().decode([Player].self, from: data)
                completed(players)
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()
    }

    func getPlayer(with: String, completed: @escaping FinishedPlayer) {
        let urlString = "http://localhost:8080/player/" + with
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("failed getting data")
                return }
            do {
                let player = try JSONDecoder().decode(DetailedPlayer.self, from: data)
                completed(player)
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()
    }
    

    func getCharities(completed: @escaping FinishedCharities) {
        let urlString = "http://localhost:8080/charities"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("failed getting data")
                return }
            do {
                let charities = try JSONDecoder().decode([Charity].self, from: data)
                    completed(charities)
            } catch let jsonErr {
                print("error serializing JSON", jsonErr)
            }
        }.resume()
    }
    
    func getMatches(completed: @escaping FinishedMatches) {
        if let user = Auth.auth().currentUser {
            let urlString = "http://localhost:8080/matches/" + user.uid
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print("failed getting data")
                    return }
                do {
                    let matches = try JSONDecoder().decode([Match].self, from: data)
                        completed(matches)
                } catch let jsonErr {
                    print("error serializing JSON", jsonErr)
                }
            }.resume()
        }
        // user could NOT be authenticated
    }
}
