//
//  TeamWithSquad.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-10.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation


struct PagedTeam: Decodable {
    
    // represents a player currently on the roster
    struct RosterPlayer:Decodable {
        let id:                   String?
        let name:                 String?
        let number:               String?
        let age:                  String?
        let position:             String?
        let injured:              String?
        let minutes:              String?
        let appearences:          String?
        let lineups:              String?
        let substitute_in:        String?
        let substitutes_on_bench: String?
        let goals:                String?
        let assists:              String?
        let yellowcards:          String?
        let yellowred:            String?
        let redcards:             String?
    }
    
    // represents a player currently injured
    struct SidelinedPlayer:Decodable {
        let name:           String?
        let description:    String?
        let startdate:      String?
        let enddate:        String?
        let id:             String?
    }
    
    // represents a player that has recently been transferred in
    struct TransferredIn:Decodable {
        let id:         String?
        let name:       String?
        let date:       String?
        let from_team:  String?
        let team_id:    String?
        let type:       String?
    }
    
    // represents a player that has recently been transferred out
    struct TransferredOut:Decodable {
        let id:         String?
        let name:       String?
        let date:       String?
        let to_team:    String?
        let team_id:    String?
        let type:       String?
    }
    
    // represents a team's stats over a season
    struct Stats:Decodable {
        let rank:                           String?
        let wins:                           String?
        let wins_home:                      String?
        let wins_away:                      String?
        let draws:                          String?
        let draws_home:                     String?
        let draws_away:                     String?
        let losses:                         String?
        let losses_home:                    String?
        let losses_away:                    String?
        let clean_sheets:                   String?
        let clean_sheets_home:              String?
        let clean_sheets_away:              String?
        let goals:                          String?
        let goals_home:                     String?
        let goals_away:                     String?
        let goals_conceded:                 String?
        let goals_conceded_home:            String?
        let goals_conceded_away:            String?
        let avg_goals_per_game_scored:      String?
        let avg_goals_per_game_scored_home: String?
        let avg_goals_per_game_scored_away: String?
        
    }
    
    let team_id:        String?
    let is_national:    String?
    let name:           String?
    let country:        String?
    let founded:        String?
    let leagues:        String?
    let venue_name:     String?
    let venue_id:       String?
    let venue_surface:  String?
    let venue_address:  String?
    let venue_city:     String?
    let venue_capacity: String?
    let coach_name:     String?
    let coach_id:       String?
    let squad:          [RosterPlayer]?
    let sidelined:      [SidelinedPlayer]?
    let transfers_in:   [TransferredIn]?
    let transfers_out:  [TransferredOut]?
    let statistics:     Stats?
}
