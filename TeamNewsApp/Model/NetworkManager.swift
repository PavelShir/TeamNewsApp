//
//  File.swift
//  TeamNewsApp
//
//  Created by Павел Широкий on 26.03.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "e9489c1c47864bfdb9d8b2da624f4591"
    private let baseUrlString = "https://newsapi.org/v2/top-headlines"

    private init() {}

    func fetchNews(category: String? = nil, query: String? = nil) async throws -> [NewsArticle] {
        var urlString = "\(baseUrlString)?apiKey=\(apiKey)"
        if let category = category {
            urlString += "&country=us&category=\(category)"
        } else if let query = query {
            urlString += "&q=\(query)"
        }

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let newsResponse = try JSONDecoder().decode(NewsData.self, from: data)
        return newsResponse.articles
    }
}
