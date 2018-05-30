//
//  Charity.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-28.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct Charity: Decodable {
    let name: String?
    let id: String?
    let description: String?
    let website: String?
    let payment_info: String?
}
