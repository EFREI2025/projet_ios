//
//  TMDBService.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import Foundation

enum TMDBError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class TMDBService {

    private let apiKey = "071a8224e84e0d8ddd1ac943ca8f69b1"
    private let baseURL = "https://api.themoviedb.org/3"

    func fetchTrendingMovies() async throws -> [MediaItem] {
        let urlString = "\(baseURL)/trending/movie/week?api_key=\(apiKey)&language=fr-FR"

        guard let url = URL(string: urlString) else {
            throw TMDBError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw TMDBError.invalidResponse
        }

        do {
            let decoded = try JSONDecoder().decode(TMDBResponse.self, from: data)
            return decoded.results
        } catch {
            throw TMDBError.decodingError
        }
    }
}
