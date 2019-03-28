//
//  Score.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
class Score: Codable{
    
    enum CodingKeys: String, CodingKey{
        case fullTime
    }
    struct fullTime: Codable{
        var homeTeam: Int?
        var awayTeam: Int?
        enum CodingKeys: String, CodingKey {
            case homeTeam
            case awayTeam
        }
    }
    let fullTime: fullTime
    
}
