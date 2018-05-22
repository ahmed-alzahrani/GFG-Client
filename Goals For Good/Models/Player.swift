//
//  Player.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-21.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation


struct Player:Decodable {
    let id: String?
    let name: String?
    let number: String?
    let age: String?
    let position: String?
    let injured: String?
    let minutes: String?
    let appearences: String?
    let lineups: String?
    let substitute_in: String?
    let substitute_out: String?
    let substitutes_on_bench: String?
    let goals: String?
    let assists: String?
    let yellowcards: String?
    let yellowred: String?
    let redcards: String?
    let team: String?
    let team_id: String?
    let league: String?
}
