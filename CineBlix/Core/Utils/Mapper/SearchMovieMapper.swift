//
//  SearchMovieMapper.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/09/25.
//

final class SearchMovieMapper {
    
    static func mapSearchMovieResponseToDomains(input searchMovieResponses: [MoviesResultResponse]) -> [SearchMovieModel] {
        return searchMovieResponses.map { response in
            return SearchMovieModel(id: response.id, posterPath: response.posterPath ?? "", title: response.title, voteAverage: response.voteAverage)
        }
    }
}
