//
//  ArticleRoot.swift
//  PREM
//
//  Created by Student on 4/16/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation





struct Response: Codable {
    let articles: [Article]
    let status: String
    let totalResults: Int
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
