//
//  GetHomeListLocaleDataSource.swift
//  Home
//
//  Created by Achmad Rijalu on 23/11/25.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetHomeListLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    
    public typealias Response = HomeMovieEntity
    
    private let _realm: Realm
    
    public init(_realm: Realm) {
        self._realm = _realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[HomeMovieEntity], any Error> {
        return Future<[HomeMovieEntity], Error> { completion in
            let movies: Results<HomeMovieEntity> = {
                _realm.objects(HomeMovieEntity.self)
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movies.toArray(ofType: HomeMovieEntity.self)))
        }
        .eraseToAnyPublisher()
    }
    
    public func add(entities: [HomeMovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for movie in entities {
                        _realm.add(movie, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<HomeMovieEntity, any Error> {
        fatalError("")
    }
    
    public func update(id: String, entities: HomeMovieEntity) -> AnyPublisher<Bool, any Error> {
        fatalError()
    }
    
}
