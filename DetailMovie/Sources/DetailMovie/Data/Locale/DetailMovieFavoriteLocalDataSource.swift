//
//  DetailMovieFavoriteLocalDataSource.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core
import Favorite
import Foundation
import RealmSwift

public struct DetailMovieFavoriteLocalDataSource: DataSource {

    public typealias Request = DetailMovieRequest
    public typealias Response = Bool

    private let realm: Realm
    private let transformer = FavoriteMovieTransformer()

    public init(realm: Realm) {
        self.realm = realm
    }

    public func execute(request: DetailMovieRequest?) -> AnyPublisher<Bool, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        return Future<Bool, Error> { completion in
            switch request {
            case .addFavorite(let movie):
                self.addFavorite(movie: movie, completion: completion)
            case .removeFavorite(let movie):
                self.removeFavorite(movie: movie, completion: completion)
            case .isFavoriteExist(let movieId):
                self.checkFavorite(movieId: movieId, completion: completion)
            case .info, .reviews, .videos:
                completion(.failure(Core.URLError.invalidResponse))
            }
        }.eraseToAnyPublisher()
    }

    private func addFavorite(
        movie: MovieResultModel,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        do {
            let entity = transformer.mapDomainToEntity(movie)
            try realm.write {
                realm.add(entity, update: .modified)
            }
            completion(.success(true))
        } catch {
            completion(.failure(DatabaseError.requestFailed))
        }
    }

    private func removeFavorite(
        movie: MovieResultModel,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        do {
            if let movieObject = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movie.id) {
                try realm.write {
                    realm.delete(movieObject)
                }
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        } catch {
            completion(.failure(DatabaseError.requestFailed))
        }
    }

    private func checkFavorite(
        movieId: Int,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        let isExist = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movieId) != nil
        completion(.success(isExist))
    }
}
