//
//  MovieRepository.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//

import Foundation
import Combine

protocol HomeRepositoryProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
}

final class HomeRepository: NSObject {
    
    typealias MovieInstance = (HomeLocaleDataSource, HomeRemoteDataSource) -> HomeRepository
    
    fileprivate let remote: HomeRemoteDataSource
    fileprivate let locale: HomeLocaleDataSource
    
    private init(remote: HomeRemoteDataSource, locale: HomeLocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return HomeRepository(remote: remoteRepo, locale: localeRepo)
        
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error> {
        return self.locale.getNowPlayingMovies().flatMap { movieEntities -> AnyPublisher<[MovieResultModel], Error> in
            if movieEntities.isEmpty {
                return self.remote.getNowPlayingMovies(page: page).map { moviesResponse in
                    MovieMapper.mapMovieResponsesToEntity(input: moviesResponse)
                }.flatMap { movieEntities in
                    self.locale.addNowPlayingMovies(from: movieEntities)
                }
                .filter { $0 }
                .flatMap { _ in self.locale.getNowPlayingMovies()
                .map { movieEntities in
                    MovieMapper.mapMovieEntityToDomains(input: movieEntities)}
                }.eraseToAnyPublisher()
            }
            else {
                return self.locale.getNowPlayingMovies().map { movieEntities in
                    MovieMapper.mapMovieEntityToDomains(input: movieEntities)
                }.eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return remote.getPopularMovies(page: page).map { movieData in
            MovieMapper.mapMovieResponsesToDomains(input: movieData)
        }.eraseToAnyPublisher()
    }
    
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return remote.getUpcomingMovies(page: page).map { movieData in
            MovieMapper.mapMovieResponsesToDomains(input: movieData)
        }.eraseToAnyPublisher()
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return remote.getTopRatedMovies(page: page).map { movieData in
            MovieMapper.mapMovieResponsesToDomains(input: movieData)
        }.eraseToAnyPublisher()
    }
}
