//
//  MovieNowPlayingMapper.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//

final class MovieNowPlayingMapper {
    
    // Map responses to entities
    static func mapMovieResponsesToEntities(
        input movieResponses: [MovieNowPlayingResultResponse]
    ) -> [MovieNowPlayingEntity] {
        return movieResponses.map { result in
            let newEntity = MovieNowPlayingEntity()
            newEntity.id = result.id ?? 0
            newEntity.title = result.title ?? "Unknown"
            newEntity.overview = result.overview ?? "No Overview"
            newEntity.posterPath = result.posterPath ?? "Unknown"
            newEntity.releaseDate = result.releaseDate ?? "Unknown"
            newEntity.voteAverage = result.voteAverage ?? 0.0
            return newEntity
        }
    }
    
    // Map entities to domains
    static func mapMovieEntitiesToDomains(
        input movieEntities: [MovieNowPlayingEntity]
    ) -> [MovieNowPlayingResultModel] {
        return movieEntities.map { entity in
            return MovieNowPlayingResultModel(
                id: entity.id,
                overview: entity.overview, posterPath: entity.posterPath, releaseDate: entity.releaseDate, title: entity.title,
                voteAverage: entity.voteAverage
            )
        }
    }
    
    // Map responses directly to domains
    static func mapMovieResponsesToDomains(
        input movieResponses: [MovieNowPlayingResultResponse]
    ) -> [MovieNowPlayingResultModel] {
        return movieResponses.map { response in
            return MovieNowPlayingResultModel(
                id: response.id ?? 0,
                overview: response.overview ?? "No Overview", posterPath: response.posterPath ?? "Unknown", releaseDate: response.releaseDate ?? "Unknown", title: response.title ?? "Unknown",
                voteAverage: response.voteAverage ?? 0.0
            )
        }
    }
}

