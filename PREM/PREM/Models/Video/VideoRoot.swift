//
//  VideoRoot.swift
//  PREM
//
//  Created by Student on 4/12/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation


struct Videos: Codable {
    let title: String
    let embed: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case embed
    }
}

struct VideoMatch: Codable {
    let title: String
    let url: URL
    let videos: [Videos]
    
    enum CodingKeys: String, CodingKey {
        case videos
        case title
        case url
    }
}
