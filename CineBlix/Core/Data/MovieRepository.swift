//
//  MovieRepository.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//


import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
//    func getPopularMovies() -> Observable<[MoviePopularListModel]>
    func getNowPlayingMovies() -> Observable<[MovieNowPlayingResultModel]>
    func getPopularMovies() -> Observable<[MoviePopularResultModel]>
}


final class MovieRepository: NSObject {
    
    typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(remote: remoteRepo, locale: localeRepo)
        
    }
    
    
}

extension MovieRepository: MovieRepositoryProtocol {
    func getPopularMovies() -> RxSwift.Observable<[MoviePopularResultModel]> {
       
    }
    
    
    
    
    func getNowPlayingMovies() -> RxSwift.Observable<[MovieNowPlayingResultModel]> {
        return self.remote.getNowPlayingMovies().map { responses in
            MovieNowPlayingMapper.mapMovieResponsesToDomains(input: responses)
        }
    }
    
    
}
