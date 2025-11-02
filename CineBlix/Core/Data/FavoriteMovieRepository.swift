//
//  FavoriteMovieRepository.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 04/10/25.
//

import Combine

protocol FavoriteMovieRepositoryProtocol: AnyObject {
    func getAllFavoritesMovies() -> AnyPublisher<[MovieResultModel], Error>
    func deleteMovieFavorite(movieId: Int) -> AnyPublisher<Bool, Error>
}

class FavoriteMovieRepository {
    fileprivate var locale: FavoriteMovieLocaleDataSource
    
    init(locale: FavoriteMovieLocaleDataSource) {
        self.locale = locale
    }
    
    static let sharedInstance: (FavoriteMovieLocaleDataSource) -> FavoriteMovieRepository = { locale in
        return FavoriteMovieRepository(locale: locale)
    }
}

extension FavoriteMovieRepository: FavoriteMovieRepositoryProtocol {
    
    func getAllFavoritesMovies() -> AnyPublisher<[MovieResultModel], any Error> {
        return locale.getMovieFavorite().map { favoriteEntities in
            FavoriteMovieMapper.mapFavoriteMovieEntitytoDomain(favoriteEntities)
        }.eraseToAnyPublisher()
    }
    
    func deleteMovieFavorite(movieId: Int) -> AnyPublisher<Bool, any Error> {
        return locale.deleteMovieFavorite(by: movieId).eraseToAnyPublisher()
    }
}
