//
//  MovieNowPlayingMapper.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//

import Realm

final class MovieMapper {
    
    static func mapMovieResponsesToDomains(
        input movieResponses: [MoviesResultResponse]
    ) -> [MovieResultModel] {
        return movieResponses.map { response in
            return MovieResultModel(id: response.id, posterPath: response.posterPath ?? "", title: response.title, voteAverage: response.voteAverage, addedAt: nil)
        }
    }
    
    static func mapMovieResponsesToEntity(input movieResponses: [MoviesResultResponse]) -> [MovieEntity] {
        return movieResponses.map { movieResponse in
            let movieEntity = MovieEntity()
            movieEntity.id = movieResponse.id
            movieEntity.posterPath = movieResponse.posterPath ?? ""
            movieEntity.title = movieResponse.title
            movieEntity.voteAverage = movieResponse.voteAverage
            return movieEntity
        }
    
    }
    
    static func mapMovieEntityToDomains( input movieEntities: [MovieEntity]) -> [MovieResultModel] {
        return movieEntities.map { movieEntity in
            return MovieResultModel(id: movieEntity.id, posterPath: movieEntity.posterPath, title: movieEntity.title, voteAverage: movieEntity.voteAverage, addedAt: nil)
        }
    }
}

