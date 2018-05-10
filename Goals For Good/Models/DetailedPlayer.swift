//
//  DetailedPlayer.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-10.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct DetailedPlayer: Decodable {
    
    struct Season: Decodable {
        let name:                   String?
        let id:                     String?
        let league:                 String?
        let league_id:              String?
        let season:                 String?
        let minutes:                String?
        let appearences:            String?
        let lineups:                String?
        let substitute_in:          String?
        let subtitute_out:          String?
        let substitute_on_bench:    String?
        let goals:                  String?
        let yellowcards:            String?
        let yellowred:              String?
        let redcards:               String?
    }
    
    struct PlayerStats: Decodable {
        let club:       [Season]?
        let cups:       [Season]?
        let club_intl:  [Season]?
        let national:   [Season]?
    }
    

    let id:                 String?
    let common_name:        String?
    let name:               String?
    let firstname:          String?
    let lastname:           String?
    let team:               String?
    let teamid:             String?
    let nationality:        String?
    let birthdate:          String?
    let age:                String?
    let birthcountry:       String?
    let birthplace:         String?
    let position:           String?
    let height:             String?
    let weight:             String?
    let player_statistics:  PlayerStats?
    
    
}
