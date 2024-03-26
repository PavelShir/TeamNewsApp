//
//  NewsData.swift
//  TeamNewsApp
//
//  Created by Павел Широкий on 26.03.2024.
//

import Foundation

struct NewsData: Decodable {
    var articles: [NewsArticle]
}

struct NewsArticle: Decodable {
    let title: String
    let source: Source
    let urlToImage: String?
    let description: String?
    var category: String?
    var author: String?
    
    struct Source: Decodable {
        let name: String
    }
}
