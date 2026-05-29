//
//  MovieResponse.swift
//  Home
//
//  Created by Achmad Rijalu on 26/11/25.
//

import Foundation
import SwiftyJSON

public struct MoviesResponse: Equatable, Sendable, Decodable {
    var dates: DatesModel?
    var page: Int
    var results: [MoviesResultResponse]
    var totalPages: Int
    var totalResults: Int

    init(json: JSON) {
        if json["dates"].exists() {
            self.dates = DatesModel(json: json["dates"])
        } else {
            self.dates = nil
        }

        self.page = json["page"].intValue
        self.results = json["results"].arrayValue.map { MoviesResultResponse(json: $0) }
        self.totalPages = json["total_pages"].intValue
        self.totalResults = json["total_results"].intValue
    }
}

public struct DatesModel: Equatable, Sendable, Decodable {
    var maximum: String?
    var minimum: String?

    init(json: JSON) {
        self.maximum = json["maximum"].string
        self.minimum = json["minimum"].string
    }
}

public struct MoviesResultResponse: Equatable, Decodable, Sendable {
    var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String?
    var releaseDate: String
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    init(json: JSON) {
        self.adult = json["adult"].boolValue
        self.backdropPath = json["backdrop_path"].string
        self.genreIds = json["genre_ids"].arrayValue.map { $0.intValue }
        self.id = json["id"].intValue
        self.originalLanguage = json["original_language"].stringValue
        self.originalTitle = json["original_title"].stringValue
        self.overview = json["overview"].stringValue
        self.popularity = json["popularity"].doubleValue
        self.posterPath = json["poster_path"].string
        self.releaseDate = json["release_date"].stringValue
        self.title = json["title"].stringValue
        self.video = json["video"].boolValue
        self.voteAverage = json["vote_average"].doubleValue
        self.voteCount = json["vote_count"].intValue
    }
}
