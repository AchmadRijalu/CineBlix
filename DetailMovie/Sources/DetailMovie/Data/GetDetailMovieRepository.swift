//
//  GetDetailMovieRepository.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core

public struct GetDetailMovieRepository: Repository {

    public typealias Request = DetailMovieRequest
    public typealias Response = DetailMovieResult

    private let remoteDataSource: GetDetailMovieRemoteDataSource
    private let localeDataSource: DetailMovieFavoriteLocalDataSource
    private let infoTransformer = DetailMovieInfoTransformer()
    private let reviewTransformer = DetailMovieReviewTransformer()
    private let videoTransformer = DetailMovieVideoTransformer()

    public init(
        remoteDataSource: GetDetailMovieRemoteDataSource,
        localeDataSource: DetailMovieFavoriteLocalDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }

    public func execute(request: DetailMovieRequest?) -> AnyPublisher<DetailMovieResult, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        switch request {
        case .info, .reviews, .videos:
            return remoteDataSource.execute(request: request)
                .map { [infoTransformer, reviewTransformer, videoTransformer] response in
                    switch response {
                    case .info(let detail):
                        return .info(infoTransformer.transformResponseToDomain(response: detail))
                    case .reviews(let detail):
                        return .reviews(reviewTransformer.transformResponseToDomain(response: detail.results))
                    case .videos(let detail):
                        return .videos(videoTransformer.transformResponseToDomain(response: detail.results))
                    }
                }
                .eraseToAnyPublisher()
        case .addFavorite, .removeFavorite, .isFavoriteExist:
            return localeDataSource.execute(request: request)
                .map { .favorite($0) }
                .eraseToAnyPublisher()
        }
    }
}
