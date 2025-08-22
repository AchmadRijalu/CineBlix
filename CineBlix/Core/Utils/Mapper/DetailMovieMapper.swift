//
//  DetailMovieMapper.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 17/07/25.
//

final class DetailMovieMapper {
    static func mapDetailMovieResponseToModel( input response: DetailMovieResponse) -> DetailMovieModel {
        return DetailMovieModel(title: response.title, overview:response.overview, backdropPath: response.backdropPath ?? "", posterPath: response.posterPath ?? "", releaseDate: response.releaseDate, voteAverage: Double(response.voteAverage), homePageLink: response.homepage ?? "", genres: response.genres.map({
            $0.name
        }), runTime: response.runtime, productionCompanies: response.productionCompanies.map({ response in
            DetailMovieProductionCompanies(name: response.name, posterPath: response.logoPath, originCountry: response.originCountry)
        }))
    }
    
    static func mapDetailMovieReviewsResponseToModel( input response: DetailMovieReviewResponse) -> [DetailMovieReviewModel] {
        let results = response.results
        return results.map {
            DetailMovieReviewModel(name: $0.author, rating: $0.rating ?? 0, content: $0.content)
        }
    }
    
    static func mapDetailMovieVideoToModel( input response: DetailMovieVideoResponse) -> [DetailMovieVideoModel] {
        let results = response.results.map { response in
            return DetailMovieVideoModel(id: response.id, movieVideoKey: response.key)
        }
        return results
    }
}
