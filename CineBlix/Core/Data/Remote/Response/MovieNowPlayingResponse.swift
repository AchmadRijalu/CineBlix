//
//  MovieResponse.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//



struct MovieNowPlayingResponse: Decodable {
    var dates: DatesResponse?
    var page: Int?
    var results: [MovieNowPlayingResultResponse]?
    var totalPages: Int?
    var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct DatesResponse: Decodable {
    var maximum: String?
    var minimum: String?
}

struct MovieNowPlayingResultResponse: Decodable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
