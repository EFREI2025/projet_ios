//
//  MediaItem.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import Foundation

import Foundation

struct MediaItem: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case rating = "vote_average"
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

import Foundation

struct TMDBResponse: Codable {
    let results: [MediaItem]
}
