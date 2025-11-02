//
//  FavoriteMovieMapper.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 16/10/25.
//

import Realm

final class FavoriteMovieMapper {
    static func mapFavoriteMovieEntitytoDomain(_ entity: [FavoriteEntity]) -> [MovieResultModel] {
        return entity.map { favoriteEntity in
            return MovieResultModel(id: favoriteEntity.id, posterPath: favoriteEntity.posterPath, title: favoriteEntity.title, voteAverage: favoriteEntity.voteAverage, addedAt: favoriteEntity.addedAt, backdropPath: favoriteEntity.backdropPath)
        }
    }
    
    static func mapDomainToFavoriteMovieEntity(_ domain: MovieResultModel) -> FavoriteEntity {
        let entity = FavoriteEntity()
        entity.id = domain.id
        entity.posterPath = domain.posterPath
        entity.title = domain.title
        entity.voteAverage = domain.voteAverage
        entity.addedAt = Date()
        return entity
    }
}
