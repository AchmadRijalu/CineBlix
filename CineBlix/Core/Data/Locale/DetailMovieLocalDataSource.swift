//
//  DetailMovieLocalDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 17/07/25.
//

import RealmSwift
import Foundation
import Combine

protocol DetailMovieLocalDataSourceProcol {
    func addMovieToFavorite(_ movieResult: MovieResultModel) -> AnyPublisher<Bool,Error>
    func deleteMovieFromFavorite(_ movieResult: MovieResultModel) -> AnyPublisher<Bool,Error>
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, Error>
}

class DetailMovieLocalDataSource: NSObject {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    static let shared: (Realm) -> DetailMovieLocalDataSource = { realm in
        return DetailMovieLocalDataSource(realm: realm)
    }
}

extension DetailMovieLocalDataSource: DetailMovieLocalDataSourceProcol {
    
    func addMovieToFavorite(_ movieResult: MovieResultModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            do {
                let entity = FavoriteMovieMapper.mapDomainToFavoriteMovieEntity(movieResult)
                try realm.write {
                    realm.add(entity, update: .modified)
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }

    func deleteMovieFromFavorite(_ movieResult: MovieResultModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }

            do {
                if let movieObject = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movieResult.id) {
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
        .eraseToAnyPublisher()
    }
    
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> {completion in
            if let realm = self.realm {
                let isExist = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movieId) != nil
                completion(.success(isExist))
            }
            else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

