//
//  DetailMovieReviewTransformer.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core

public struct DetailMovieReviewTransformer: Mapper {

    public typealias Response = [ReviewResponse]
    public typealias Entity = [DetailMovieReviewModel]
    public typealias Domain = [DetailMovieReviewModel]

    public init() {}

    public func transformResponseToEntity(response: [ReviewResponse]) -> [DetailMovieReviewModel] {
        response.map {
            DetailMovieReviewModel(
                name: $0.author,
                rating: $0.rating ?? 0,
                content: $0.content
            )
        }
    }

    public func transformEntityToDomain(entity: [DetailMovieReviewModel]) -> [DetailMovieReviewModel] {
        entity
    }
}
