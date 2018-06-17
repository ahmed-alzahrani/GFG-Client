//
//  SearchBarValidator.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-25.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct SearchBarValidator {
    
    func playerValidator(player: Player, text: String) -> Bool {
        return player.name!.contains(String(text)) || player.league!.contains(String(text)) || player.team!.contains(String(text)) || player.position!.contains(String(text)) || player.id!.contains(String(text)) || player.number!.contains(String(text)) || player.age!.contains(String(text))
    }
    
    func charityValidator(charity: Charity, text: String) -> Bool {
        return charity.name!.contains(text) || charity.id!.contains(text) || charity.website!.contains(text) || charity.description!.contains(text)
    }
    
    func subscriptionValidator(subscription: Subscription, text: String) -> Bool {
        return subscription.id!.contains(String(text)) || subscription.charity!.contains(String(text)) || subscription.charityId!.contains(String(text)) || subscription.name!.contains(String(text))
    }
    
    func matchValidator(match: Match, text: String) -> Bool {
        return match.comp_id!.contains(String(text)) || match.visitorteam_name!.contains(String(text)) || match.localteam_name!.contains(String(text)) || match.venue!.contains(String(text))
    }
}
