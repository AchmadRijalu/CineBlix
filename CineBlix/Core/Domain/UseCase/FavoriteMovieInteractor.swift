//
//  FavoriteMovieInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 19/10/25.
//

import Combine

protocol FavoriteMovieUseCase: AnyObject {
    func fetchFavoriteMovies() -> AnyPublisher<[MovieResultModel], Error>
    func deleteFavoriteMovie(movieId: Int) -> AnyPublisher<Bool, Error>
}

class FavoriteMovieInteractor: FavoriteMovieUseCase {
    
    private let repository: FavoriteMovieRepositoryProtocol
    
    init(repository: FavoriteMovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchFavoriteMovies() -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getAllFavoritesMovies()
    }
    
    func deleteFavoriteMovie(movieId: Int) -> AnyPublisher<Bool, any Error> {
        return repository.deleteMovieFavorite(movieId: movieId)
    }
}
