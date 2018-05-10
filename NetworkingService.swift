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
    
    let configuration = config()
    
    static let shared = NetworkingService()
    private init() {}
    
    func getTeams() -> [Team]{
        var count = 0
        var teams = [Team]()
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
        while (count < 17){
            continue
        }
        print(teams.count)
        return teams
    }
}
    

