//
//  GetHomeListLocaleDataSource.swift
//  Home
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetHomeListLocaleDataSource: LocaleDataSource {

    public typealias Request = HomeListRequest
    public typealias Response = HomeMovieEntity

    private let realm: Realm

    public init(_realm: Realm) {
        self.realm = _realm
    }

    public func list(request: HomeListRequest?) -> AnyPublisher<[HomeMovieEntity], any Error> {
        let listType = request?.listType ?? HomeListRequest.nowPlayingListType
        return Future<[HomeMovieEntity], Error> { completion in
            let movies = realm.objects(HomeMovieEntity.self)
                .where { $0.listType == listType }
                .sorted(byKeyPath: "title", ascending: true)
            completion(.success(movies.toArray(ofType: HomeMovieEntity.self)))
        }
        .eraseToAnyPublisher()
    }

    public func add(entities: [HomeMovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try realm.write {
                    for movie in entities {
                        realm.add(movie, update: .all)
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
        fatalError("Not implemented")
    }

    public func update(id: String, entities: HomeMovieEntity) -> AnyPublisher<Bool, any Error> {
        fatalError("Not implemented")
    }
}
