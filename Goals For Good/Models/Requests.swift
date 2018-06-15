//
//  Requests.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation


struct SubCheckParams: Codable {
    let uid: String?
    let playerId: String?
}

struct AddSubParams: Codable {
    let uid: String?
    let playerId: String?
    let name: String?
    let team: String?
    let teamName: String?
    let charityName: String?
    let charityId: String?
}

struct RemoveSubParams: Codable {
    let uid: String?
    let playerId: String?
}
