//
//  DetailMovieModel.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct DetailMovieVideoModel: Equatable, Sendable {
    public let id: String
    public let movieVideoKey: String

    public init(id: String, movieVideoKey: String) {
        self.id = id
        self.movieVideoKey = movieVideoKey
    }
}

public struct DetailMovieModel: Sendable {
    public let title: String
    public let overview: String
    public let backdropPath: String
    public let posterPath: String
    public let releaseDate: String
    public let voteAverage: Double
    public let homePageLink: String
    public let genres: [String]
    public let runTime: Int
    public let productionCompanies: [DetailMovieProductionCompanies]

    public init(
        title: String,
        overview: String,
        backdropPath: String,
        posterPath: String,
        releaseDate: String,
        voteAverage: Double,
        homePageLink: String,
        genres: [String],
        runTime: Int,
        productionCompanies: [DetailMovieProductionCompanies]
    ) {
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.homePageLink = homePageLink
        self.genres = genres
        self.runTime = runTime
        self.productionCompanies = productionCompanies
    }
}

public struct DetailMovieProductionCompanies: Hashable, Sendable {
    public var name: String
    public var posterPath: String?
    public var originCountry: String

    public init(name: String, posterPath: String?, originCountry: String) {
        self.name = name
        self.posterPath = posterPath
        self.originCountry = originCountry
    }
}

public struct DetailMovieReviewModel: Hashable, Identifiable, Equatable, Sendable {
    public var id: UUID
    public let name: String
    public let rating: Double
    public let content: String

    public init(id: UUID = UUID(), name: String, rating: Double, content: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.content = content
    }
}
