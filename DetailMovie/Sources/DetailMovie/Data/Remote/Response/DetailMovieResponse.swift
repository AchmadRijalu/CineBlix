//
//  DetailMovieResponse.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct DetailMovieResponse: Decodable, Sendable {
    public let id: Int
    public let title: String
    public let originalTitle: String
    public let overview: String
    public let releaseDate: String
    public let runtime: Int
    public let voteAverage: Double
    public let voteCount: Int
    public let posterPath: String?
    public let backdropPath: String?
    public let tagline: String?
    public let homepage: String?
    public let budget: Int
    public let revenue: Int
    public let status: String
    public let isAdult: Bool
    public let genres: [GenreResultResponse]
    public let productionCompanies: [ProductionCompanyResponse]

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, homepage, genres, budget, revenue, status, adult, tagline
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case productionCompanies = "production_companies"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        budget = try container.decodeIfPresent(Int.self, forKey: .budget) ?? 0
        revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        isAdult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
        genres = try container.decodeIfPresent([GenreResultResponse].self, forKey: .genres) ?? []
        productionCompanies = try container.decodeIfPresent(
            [ProductionCompanyResponse].self,
            forKey: .productionCompanies
        ) ?? []
    }
}

public struct GenreResultResponse: Decodable, Sendable {
    public let id: Int
    public let name: String
}

public struct ProductionCompanyResponse: Decodable, Sendable {
    public let id: Int
    public let name: String
    public let originCountry: String
    public let logoPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case originCountry = "origin_country"
        case logoPath = "logo_path"
    }
}
