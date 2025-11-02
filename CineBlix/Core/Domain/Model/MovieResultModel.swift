//
//  MovieNowPlayingListModel.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation

struct MovieResultModel: Equatable, Identifiable {
    let id: Int
    let posterPath: String
    var title: String
    let voteAverage: Double
    let addedAt: Date?
    let backdropPath: String?
}

