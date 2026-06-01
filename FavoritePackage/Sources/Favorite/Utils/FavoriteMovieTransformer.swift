//
//  FavoriteMovieTransformer.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core
import Foundation

public struct FavoriteMovieTransformer {

    public init() {}

    public func mapDomainToEntity(_ domain: MovieResultModel) -> FavoriteEntity {
        let entity = FavoriteEntity()
        entity.id = domain.id
        entity.posterPath = domain.posterPath
        entity.title = domain.title
        entity.voteAverage = domain.voteAverage
        entity.addedAt = domain.addedAt ?? Date()
        entity.backdropPath = domain.backdropPath ?? ""
        return entity
    }

    public func mapEntityToDomain(_ entities: [FavoriteEntity]) -> [MovieResultModel] {
        entities.map { entity in
            MovieResultModel(
                id: entity.id,
                posterPath: entity.posterPath,
                title: entity.title,
                voteAverage: entity.voteAverage,
                addedAt: entity.addedAt,
                backdropPath: entity.backdropPath
            )
        }
    }
}
