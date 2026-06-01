//
//  SearchResultTransformer.swift
//  Search
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core

public struct SearchResultTransformer: Mapper {

    public typealias Response = [MoviesResultResponse]
    public typealias Entity = [SearchMovieModel]
    public typealias Domain = [SearchMovieModel]

    public init() {}

    public func transformResponseToEntity(response: [MoviesResultResponse]) -> [SearchMovieModel] {
        mapToDomain(response)
    }

    public func transformEntityToDomain(entity: [SearchMovieModel]) -> [SearchMovieModel] {
        entity
    }

    private func mapToDomain(_ response: [MoviesResultResponse]) -> [SearchMovieModel] {
        response.map { result in
            SearchMovieModel(
                id: result.id,
                posterPath: result.posterPath ?? "",
                title: result.title,
                voteAverage: result.voteAverage
            )
        }
    }
}
