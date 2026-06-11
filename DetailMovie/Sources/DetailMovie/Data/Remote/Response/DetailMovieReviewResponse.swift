//
//  DetailMovieReviewResponse.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct DetailMovieReviewResponse: Decodable, Sendable {
    public let id: Int
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    public let results: [ReviewResponse]

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct ReviewResponse: Decodable, Sendable {
    public let id: String
    public let author: String
    public let content: String
    public let rating: Double?
    public let createdAt: String
    public let updatedAt: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case id, author, content, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case authorDetails = "author_details"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""

        if let authorDetails = try container.decodeIfPresent(AuthorDetailsResponse.self, forKey: .authorDetails) {
            rating = authorDetails.rating
        } else {
            rating = nil
        }
    }
}

private struct AuthorDetailsResponse: Decodable, Sendable {
    let rating: Double?
}
