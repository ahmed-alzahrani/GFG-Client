//
//  SearchBarValidator.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-25.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct SearchBarValidator {
    
    func searchValidator(player: Player, text: String) -> Bool {
        return player.name!.contains(String(text)) || player.league!.contains(String(text)) || player.team!.contains(String(text)) || player.position!.contains(String(text)) || player.id!.contains(String(text)) || player.number!.contains(String(text)) || player.age!.contains(String(text))
    }
}
