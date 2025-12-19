//
//  Playlist.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import Foundation
import SwiftData

@Model
class Playlist {
    var name: String
    var details: String?
    var createdAt: Date

    // relation vers des items de playlist
    @Relationship(deleteRule: .cascade) var items: [PlaylistItem] = []

    init(name: String, details: String? = nil) {
        self.name = name
        self.details = details
        self.createdAt = Date()
    }
}

@Model
class PlaylistItem {
    var mediaId: Int
    var title: String
    var posterPath: String?
    var rating: Double?

    init(mediaId: Int, title: String, posterPath: String?, rating: Double?) {
        self.mediaId = mediaId
        self.title = title
        self.posterPath = posterPath
        self.rating = rating
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
