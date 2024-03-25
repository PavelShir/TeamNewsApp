//
//  NewResponseModel.swift
//  TeamNewsApp
//
//  Created by Виталик Молоков on 24.03.2024.
//

import Foundation

struct NewsResponse: Decodable {
    var articles: [NewsArticle]
}

struct NewsArticle: Decodable {
    let title: String
    let source: Source
    let urlToImage: String?
    var category: String?
    
    struct Source: Decodable {
        let name: String
    }
}
