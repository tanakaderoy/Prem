//
//  StandingsRoot.swift
//  PREM
//
//  Created by Student on 4/9/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation

struct TableTeam: Codable {
    let id: Int
    let name: String
    let crestUrl: String
}


struct Result: Codable {
    let position: Int
    let team: TableTeam
    let playedGames: Int
    let won: Int
    let draw: Int
    let lost: Int
    let points: Int
    let goalDifference: Int
    
    
    enum CodingKeys: String, CodingKey {
        case position
        case team
        case playedGames
        case won
        case draw
        case lost
        case points
        case goalDifference
    }
}

struct StandingGroup: Codable {
    let table: [Result]
    
    enum CodingKeys: String, CodingKey {
        case table
    }
}

struct Standing: Codable {
    let standings: [StandingGroup]
    
    enum CodingKeys: String, CodingKey {
        case standings
    }
}
