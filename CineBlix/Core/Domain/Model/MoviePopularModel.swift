//
//  MoviePopularListModel.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation

struct MoviePopularModel {
    var page: Int
    var results: [MoviePopularResultModel]
    var totalPages: Int
    var totalResults: Int
}

struct MoviePopularResultModel {
    var id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var posterPath: String
    var voteAverage: Double
    var genreIDs: [Int]
}


