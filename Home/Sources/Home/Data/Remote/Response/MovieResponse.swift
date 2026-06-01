//
//  MovieResponse.swift
//  Home
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct MoviesResponse: Equatable, Sendable, Decodable {
    public let dates: DatesModel?
    public let page: Int
    public let results: [MoviesResultResponse]
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct DatesModel: Equatable, Sendable, Decodable {
    public let maximum: String?
    public let minimum: String?
}

public struct MoviesResultResponse: Equatable, Decodable, Sendable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIds: [Int]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate: String
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
