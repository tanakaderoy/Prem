//
//  HomeTeam.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation

class HomeTeam: Codable{
    var id: Int
    var name: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
