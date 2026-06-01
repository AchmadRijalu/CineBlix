//
//  SearchMovieModel.swift
//  Search
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct SearchMovieModel: Equatable, Identifiable, Sendable {
    public let id: Int
    public let posterPath: String
    public var title: String
    public let voteAverage: Double

    public init(id: Int, posterPath: String, title: String, voteAverage: Double) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
    }
}
