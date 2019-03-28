//
//  Score.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
class Score: Codable{
    let fulltime: fulltime
    enum CodingKeys: String, CodingKey{
        case fulltime
    }
    struct fulltime: Codable{
        var homeTeam: Int
        var awayTeam: Int
        enum CodingKeys: String, CodingKey {
            case homeTeam
            case awayTeam
        }
    }
    
}
