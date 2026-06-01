//
//  GetFavoriteLocaleDataSource.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core
import Foundation
import RealmSwift

public enum FavoriteLocaleResponse {
    case list([FavoriteEntity])
    case deleted(Bool)
}

public struct GetFavoriteLocaleDataSource: DataSource {

    public typealias Request = FavoriteRequest
    public typealias Response = FavoriteLocaleResponse

    private let realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public func execute(request: FavoriteRequest?) -> AnyPublisher<FavoriteLocaleResponse, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        return Future { [self] completion in
            switch request {
            case .list:
                self.fetchAll(completion: completion)
            case .delete(let movieId):
                self.delete(movieId: movieId, completion: completion)
            }
        }
        .eraseToAnyPublisher()
    }

    private func fetchAll(completion: @escaping (Result<FavoriteLocaleResponse, Error>) -> Void) {
        let movies: Results<FavoriteEntity> = realm.objects(FavoriteEntity.self)
            .sorted(byKeyPath: "addedAt", ascending: true)
        completion(.success(.list(movies.toArray(ofType: FavoriteEntity.self))))
    }

    private func delete(
        movieId: Int,
        completion: @escaping (Result<FavoriteLocaleResponse, Error>) -> Void
    ) {
        do {
            if let movie = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movieId) {
                try realm.write {
                    realm.delete(movie)
                }
                completion(.success(.deleted(true)))
            } else {
                completion(.success(.deleted(false)))
            }
        } catch {
            completion(.failure(DatabaseError.requestFailed))
        }
    }
}
