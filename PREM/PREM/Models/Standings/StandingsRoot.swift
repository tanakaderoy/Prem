//
//  StandingsRoot.swift
//  PREM
//
//  Created by Student on 4/9/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
class StandingsRoot: Codable {
    let standings: [Standings]
    
}

class Standings: Codable {
    let table: [Table]
}
class Table: Codable {
    let position:Int
    let team: TableTeam
    struct TableTeam: Codable {
        let id: Int
        let name: String
        let crestUrl: URL
    }
    let playedGames: Int
    let won: Int
    let draw: Int
    let lost: Int
    let points: Int
    let goalDifference: Int
}
