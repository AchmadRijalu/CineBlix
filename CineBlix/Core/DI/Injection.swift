//
//  Injection.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    //MARK: - Repository Injection
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: HomeRemoteDataSource = HomeRemoteDataSource.sharedInstance
        
        return MovieRepository.sharedInstance(locale, remote)
    }
    
    private func provideDetailMovieRepository() -> DetailMovieRepositoryProtocol {
        let realm = try? Realm()
        let locale: DetailMovieLocalDataSource = DetailMovieLocalDataSource(realm: realm)
        let remote: DetailMovieRemoteDataSource = DetailMovieRemoteDataSource()
        
        return DetailMovieRepository.sharedInstance(remote, locale)
    }

    func provideHome() -> HomeUseCase {
        let repository = provideMovieRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetailMovie() -> DetailMovieUseCase {
        let repository = provideDetailMovieRepository()
        return DetailMovieInteractor(repository: repository)
    }
    
}
