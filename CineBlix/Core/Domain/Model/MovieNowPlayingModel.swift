//
//  MovieNowPlayingListModel.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation


struct MovieNowPlayingModel: Equatable, Identifiable {
    let id = UUID()
    var dates: DatesModel?
    var page: Int?
    var results: [MovieNowPlayingResultModel]?
    var totalPages: Int?
    var totalResults: Int?
}

struct DatesModel: Equatable {
    var maximum: String?
    var minimum: String?
}

struct MovieNowPlayingResultModel: Equatable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDs: [Int]?
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
}

