//
//  DetailMovieInfoTransformer.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core

public struct DetailMovieInfoTransformer: Mapper {

    public typealias Response = DetailMovieResponse
    public typealias Entity = DetailMovieModel
    public typealias Domain = DetailMovieModel

    public init() {}

    public func transformResponseToEntity(response: DetailMovieResponse) -> DetailMovieModel {
        DetailMovieModel(
            title: response.title,
            overview: response.overview,
            backdropPath: response.backdropPath ?? "",
            posterPath: response.posterPath ?? "",
            releaseDate: response.releaseDate,
            voteAverage: response.voteAverage,
            homePageLink: response.homepage ?? "",
            genres: response.genres.map(\.name),
            runTime: response.runtime,
            productionCompanies: response.productionCompanies.map {
                DetailMovieProductionCompanies(
                    name: $0.name,
                    posterPath: $0.logoPath,
                    originCountry: $0.originCountry
                )
            }
        )
    }

    public func transformEntityToDomain(entity: DetailMovieModel) -> DetailMovieModel {
        entity
    }
}
