//
//  NewsAPIServices.swift
//  TeamNewsApp
//
//  Created by Виталик Молоков on 24.03.2024.
//

import Foundation

class NewsAPIService {
    static let shared = NewsAPIService()
    private let apiKey = "f77ed22e15ba438e81f473d6054d7975"
    private let baseUrlString = "https://newsapi.org/v2/top-headlines"

    private init() {}

    func loadNews(forCategory category: String) async throws -> [NewsArticle] {
        let country = "us"
        let urlString = "\(baseUrlString)?country=\(country)&category=\(category)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        print(String(decoding: data, as: UTF8.self))
        var newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        for i in newsResponse.articles.indices {
            newsResponse.articles[i].category = category.capitalized
        }
        return newsResponse.articles
    }
    
    func searchNews(withQuery query: String) async throws -> [NewsArticle] {
           let urlString = "\(baseUrlString)?q=\(query)&apiKey=\(apiKey)"
           guard let url = URL(string: urlString) else {
               throw URLError(.badURL)
           }

           let (data, _) = try await URLSession.shared.data(from: url)
           let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
           return newsResponse.articles
       }
}
