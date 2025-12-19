import Foundation
import SwiftData

enum WatchState: String, Codable {
    case none
    case wantToWatch
    case watched
}

@Model
class UserMediaStatus {
    @Attribute(.unique) var mediaId: Int

    var title: String
    var posterPath: String?
    var rating: Double?

    var isFavorite: Bool
    var watchStateRaw: String  // stocké en String (SwiftData friendly)

    var personalNote: String?
    var personalRating: Int? // 1...10

    init(mediaId: Int, title: String, posterPath: String?, rating: Double?) {
        self.mediaId = mediaId
        self.title = title
        self.posterPath = posterPath
        self.rating = rating
        self.isFavorite = false
        self.watchStateRaw = WatchState.none.rawValue
    }

    var watchState: WatchState {
        get { WatchState(rawValue: watchStateRaw) ?? .none }
        set { watchStateRaw = newValue.rawValue }
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
