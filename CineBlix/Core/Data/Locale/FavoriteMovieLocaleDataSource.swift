//
//  FavoriteMovieLocaleDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 04/10/25.
//

import RealmSwift
import Combine

protocol FavoriteMovieLocaleDataSourceProtocol: AnyObject {
    func getMovieFavorite() -> AnyPublisher<[FavoriteEntity], Error>
    func deleteMovieFavorite(by id: Int) -> AnyPublisher<Bool, Error>
}

final class FavoriteMovieLocaleDataSource {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    static let shared: (Realm?) -> FavoriteMovieLocaleDataSource = { realm in
        return FavoriteMovieLocaleDataSource(realm: realm)
    }
}

extension FavoriteMovieLocaleDataSource: FavoriteMovieLocaleDataSourceProtocol {
    
    func getMovieFavorite() -> AnyPublisher<[FavoriteEntity], any Error> {
        return Future<[FavoriteEntity], Error> { completion in
            if let realm = self.realm {
                let movies: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .sorted(byKeyPath: "addedAt", ascending: true)
                }()
                completion(.success(movies.toArray(ofType: FavoriteEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteMovieFavorite(by id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            do {
                if let movie = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id) {
                    try realm.write {
                        realm.delete(movie)
                    }
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}

