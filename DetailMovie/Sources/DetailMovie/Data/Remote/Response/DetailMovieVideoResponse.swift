//
//  DetailMovieVideoResponse.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public struct DetailMovieVideoResponse: Decodable, Sendable {
    public let id: Int
    public let results: [VideoResponse]
}

public struct VideoResponse: Decodable, Sendable {
    public let id: String
    public let name: String
    public let key: String
    public let site: String
    public let type: String
    public let official: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, key, site, type, official
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let stringId = try? container.decode(String.self, forKey: .id) {
            id = stringId
        } else if let intId = try? container.decode(Int.self, forKey: .id) {
            id = String(intId)
        } else {
            id = ""
        }
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
        site = try container.decodeIfPresent(String.self, forKey: .site) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        official = try container.decodeIfPresent(Bool.self, forKey: .official) ?? false
    }
}
