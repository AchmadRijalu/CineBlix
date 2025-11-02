//
//  LocalDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//

import Foundation
import RealmSwift
import Combine

protocol HomeLocaleDataSourceProtocol {
    func getNowPlayingMovies() -> AnyPublisher<[MovieEntity], Error>
    func addNowPlayingMovies(from movieEntities: [MovieEntity]) -> AnyPublisher<Bool, Error>
}

class HomeLocaleDataSource: NSObject {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> HomeLocaleDataSource = { realmInstance in
        return HomeLocaleDataSource(realm: realmInstance)
    }
}

extension HomeLocaleDataSource: HomeLocaleDataSourceProtocol {
    func getNowPlayingMovies() -> AnyPublisher<[MovieEntity], any Error> {
        return Future<[MovieEntity], Error> { completion in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(movies.toArray(ofType: MovieEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addNowPlayingMovies(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for movie in movies {
                            realm.add(movie, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
