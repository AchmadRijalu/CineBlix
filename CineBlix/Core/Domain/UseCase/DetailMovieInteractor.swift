//
//  DetailMovieInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core
import DetailMovie

protocol DetailMovieUseCase: AnyObject {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, Error>
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], Error>
    func getDetailMovieVideos(movieId: Int) -> AnyPublisher<[DetailMovieVideoModel], Error>
    func addFavoriteMovie(movieResultModel: MovieResultModel) -> AnyPublisher<Bool, Error>
    func removeFavoriteMovie(movieResult: MovieResultModel) -> AnyPublisher<Bool, Error>
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, Error>
}

typealias DetailMovieUseCaseInteractor = Interactor<
    DetailMovieRequest,
    DetailMovieResult,
    GetDetailMovieRepository
>

final class DetailMovieInteractor: DetailMovieUseCase {

    private let useCase: DetailMovieUseCaseInteractor

    init(useCase: DetailMovieUseCaseInteractor) {
        self.useCase = useCase
    }

    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, Error> {
        useCase.execute(
            request: .info(endpointURL: Endpoints.Gets.movieInfo(movieId: movieId).url)
        )
        .tryMap { result in
            guard case .info(let model) = result else {
                throw Core.URLError.invalidResponse
            }
            return model
        }
        .eraseToAnyPublisher()
    }

    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], Error> {
        useCase.execute(
            request: .reviews(endpointURL: Endpoints.Gets.movieReview(movieId: movieId).url)
        )
        .tryMap { result in
            guard case .reviews(let models) = result else {
                throw Core.URLError.invalidResponse
            }
            return models
        }
        .eraseToAnyPublisher()
    }

    func getDetailMovieVideos(movieId: Int) -> AnyPublisher<[DetailMovieVideoModel], Error> {
        useCase.execute(
            request: .videos(endpointURL: Endpoints.Gets.movieVideo(movieId: movieId).url)
        )
        .tryMap { result in
            guard case .videos(let models) = result else {
                throw Core.URLError.invalidResponse
            }
            return models
        }
        .eraseToAnyPublisher()
    }

    func addFavoriteMovie(movieResultModel: MovieResultModel) -> AnyPublisher<Bool, Error> {
        useCase.execute(request: .addFavorite(movieResultModel))
            .tryMap { result in
                guard case .favorite(let success) = result else {
                    throw Core.URLError.invalidResponse
                }
                return success
            }
            .eraseToAnyPublisher()
    }

    func removeFavoriteMovie(movieResult: MovieResultModel) -> AnyPublisher<Bool, Error> {
        useCase.execute(request: .removeFavorite(movieResult))
            .tryMap { result in
                guard case .favorite(let success) = result else {
                    throw Core.URLError.invalidResponse
                }
                return success
            }
            .eraseToAnyPublisher()
    }

    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, Error> {
        useCase.execute(request: .isFavoriteExist(movieId: movieId))
            .tryMap { result in
                guard case .favorite(let exists) = result else {
                    throw Core.URLError.invalidResponse
                }
                return exists
            }
            .eraseToAnyPublisher()
    }
}
