//
//  Match.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-14.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct Match: Codable {
    
    struct Event: Codable {
        let id: String?
        let type: String?
        let minute: String?
        let extra_min: String?
        let team: String?
        let player: String?
        let player_id: String?
        let assist: String?
        let assist_id: String?
        let result: String?
    }
    
    let id: String?
    let comp_id: String?
    let formatted_date: String?
    let season: String?
    let week: String?
    let venue: String?
    let venue_id: String?
    let venue_city: String?
    let status: String?
    let timer: String?
    let time: String?
    let localteam_id: String?
    let localteam_name: String?
    let localteam_score: String?
    let visitorteam_id: String?
    let visitorteam_name: String?
    let visitorteam_score: String?
    let ht_score: String?
    let ft_score: String?
    let et_score: String?
    let penalty_local: String?
    let penalty_visitor: String?
    let events: [Event]
}
