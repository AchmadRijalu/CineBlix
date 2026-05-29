//
//  MovieResultModel.swift
//  Core
//

import Foundation

public struct MovieResultModel: Equatable, Identifiable, Sendable {
    public let id: Int
    public let posterPath: String
    public var title: String
    public let voteAverage: Double
    public let addedAt: Date?
    public let backdropPath: String?

    public init(
        id: Int,
        posterPath: String,
        title: String,
        voteAverage: Double,
        addedAt: Date?,
        backdropPath: String?
    ) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
        self.addedAt = addedAt
        self.backdropPath = backdropPath
    }
}
