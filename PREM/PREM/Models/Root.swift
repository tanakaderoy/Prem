//
//  Matches.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
class Root: Codable {
    struct Filters: Codable {
        let matchday: Int
    }
    let filters: Filters
    let matches: [MatchDay]
}
