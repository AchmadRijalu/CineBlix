//
//  MovieRepository.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
}


final class MovieRepository: NSObject {
    
    typealias MovieInstance = (LocaleDataSource, HomeRemoteDataSource) -> MovieRepository
    
    fileprivate let remote: HomeRemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: HomeRemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(remote: remoteRepo, locale: localeRepo)
        
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error> {
        return remote.getNowPlayingMovies(page: page).map {
            MovieMapper.mapMovieResponsesToDomains(input: $0)
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
