//
//  MovieResultTransformer.swift
//  Home
//
//  Created by Achmad Rijalu on 29/11/25.
//

import Core

public struct MovieResultTransformer: Mapper {
    
    public typealias Response = [MoviesResultResponse]
    
    public typealias Entity = [HomeMovieEntity]
    
    public typealias Domain = [MovieResultModel]
    
    public init() {}
    
    public func transformResponseToEntity(
        response: [MoviesResultResponse]
    ) -> [HomeMovieEntity] {
        return response
            .map { result in
                let homeMovieEntity = HomeMovieEntity()
                homeMovieEntity.id = result.id
                homeMovieEntity.posterPath = result.posterPath ?? ""
                homeMovieEntity.title = result.title
                homeMovieEntity.voteAverage = result.voteAverage
                homeMovieEntity.backdropPath = result.backdropPath ?? ""
                return homeMovieEntity
            }
    }
    
    public func transformEntityToDomain(
        entity: [HomeMovieEntity]
    ) -> [MovieResultModel] {
        entity.map(mapEntity)
    }

    private func mapEntity(_ result: HomeMovieEntity) -> MovieResultModel {
        MovieResultModel(
            id: result.id,
            posterPath: result.posterPath,
            title: result.title,
            voteAverage: result.voteAverage,
            addedAt: nil,
            backdropPath: result.backdropPath
        )
    }
}

