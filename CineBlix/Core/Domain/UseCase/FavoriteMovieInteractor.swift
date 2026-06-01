//
//  FavoriteMovieInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core
import Favorite

protocol FavoriteMovieUseCase: AnyObject {
    func fetchFavoriteMovies() -> AnyPublisher<[MovieResultModel], Error>
    func deleteFavoriteMovie(movieId: Int) -> AnyPublisher<Bool, Error>
}

typealias FavoriteUseCaseInteractor = Interactor<
    FavoriteRequest,
    FavoriteResult,
    GetFavoriteRepository
>

final class FavoriteMovieInteractor: FavoriteMovieUseCase {

    private let useCase: FavoriteUseCaseInteractor

    init(useCase: FavoriteUseCaseInteractor) {
        self.useCase = useCase
    }

    func fetchFavoriteMovies() -> AnyPublisher<[MovieResultModel], Error> {
        useCase.execute(request: .list)
            .tryMap { result in
                guard case .movies(let movies) = result else {
                    throw Core.URLError.invalidResponse
                }
                return movies
            }
            .eraseToAnyPublisher()
    }

    func deleteFavoriteMovie(movieId: Int) -> AnyPublisher<Bool, Error> {
        useCase.execute(request: .delete(movieId: movieId))
            .tryMap { result in
                guard case .deleted(let success) = result else {
                    throw Core.URLError.invalidResponse
                }
                return success
            }
            .eraseToAnyPublisher()
    }
}
