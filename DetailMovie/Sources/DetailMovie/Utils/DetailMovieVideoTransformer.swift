//
//  DetailMovieVideoTransformer.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core

public struct DetailMovieVideoTransformer: Mapper {

    public typealias Response = [VideoResponse]
    public typealias Entity = [DetailMovieVideoModel]
    public typealias Domain = [DetailMovieVideoModel]

    public init() {}

    public func transformResponseToEntity(response: [VideoResponse]) -> [DetailMovieVideoModel] {
        response.map {
            DetailMovieVideoModel(id: $0.id, movieVideoKey: $0.key)
        }
    }

    public func transformEntityToDomain(entity: [DetailMovieVideoModel]) -> [DetailMovieVideoModel] {
        entity
    }
}
