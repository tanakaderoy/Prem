//
//  MatcheData.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation


class MatchDay: Codable {
    
    var id: Int
    var utcDate: String
    var status: String//Status
    var matchday: Int?
    let score: Score
    let homeTeam: HomeTeam
    let awayTeam: AwayTeam
    let season: Season
    
    struct Season:Codable {
        let id: Int
        let currentMatchday: Int
        enum CodingKeys: String, CodingKey{
            case id
            case currentMatchday
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case season
        case utcDate
        case status
        case matchday
        case score
        case homeTeam
        case awayTeam
    }
    
    
    
}
