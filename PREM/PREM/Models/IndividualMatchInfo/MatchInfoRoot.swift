//
//  MatchInfoRoot.swift
//  PREM
//
//  Created by Student on 4/1/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
class MatchInfoRoot: Codable {
    let headToHead: HeadToHead
    let match: IndividualMatch
    enum CodingKeys: String, CodingKey {
        case headToHead = "head2head"
        case match
    }
}

class HeadToHead: Codable{
    var numberOfMatches: Int
    var totalGoals: Int
    let homeTeam: HomeTeamHTH
    let awayTeam: AwayTeamHTH
    struct HomeTeamHTH: Codable {
        var wins: Int
        var draws: Int
        var losses: Int
    }
    struct AwayTeamHTH: Codable {
        var wins: Int
        var draws: Int
        var losses: Int
    }
    
    
}

class IndividualMatch:Codable {
    var id: Int
    var utcDate: String
    var status: String
    var venue: String
    var matchday: Int
    var score: Score
    var homeTeam: HomeTeam
    var awayTeam: AwayTeam
    var referees: [Referees]
    
}
class Referees: Codable {
    var id: Int
    var name: String
}
