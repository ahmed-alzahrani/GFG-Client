//
//  Subscription.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-06-12.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct Subscription: Decodable {
    let id: String?
    let charity: String?
    let charityId: String?
    let name: String?
    let time: String?
}
