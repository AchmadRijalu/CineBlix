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
    private func provideMovieRepository() -> HomeRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: HomeLocaleDataSource = HomeLocaleDataSource.sharedInstance(realm)
        let remote: HomeRemoteDataSource = HomeRemoteDataSource.sharedInstance
        
        return HomeRepository.sharedInstance(locale, remote)
    }
    
    private func provideDetailMovieRepository() -> DetailMovieRepositoryProtocol {
        let realm = try? Realm()
        let locale: DetailMovieLocalDataSource = DetailMovieLocalDataSource(realm: realm)
        let remote: DetailMovieRemoteDataSource = DetailMovieRemoteDataSource()
        
        return DetailMovieRepository.sharedInstance(remote, locale)
    }
    
    private func provideSearchMovieRepository() -> SearchMovieRepositoryProtocol {
        let remote: SearchMovieRemoteDataSource = SearchMovieRemoteDataSource()
        return SearchMovieRepository.sharedInstance(remote)
    }
    
    private func provideFavoriteMovieRepository() -> FavoriteMovieRepositoryProtocol {
        let realm = try? Realm()
        let locale: FavoriteMovieLocaleDataSource = FavoriteMovieLocaleDataSource(realm: realm)
        return FavoriteMovieRepository.sharedInstance(locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideMovieRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetailMovie() -> DetailMovieUseCase {
        let repository = provideDetailMovieRepository()
        return DetailMovieInteractor(repository: repository)
    }
    
    func provideSearchMovie() -> SearchMovieUserCase {
        let repository = provideSearchMovieRepository()
        return SearchMovieInteractor(repository: repository)
    }
    
    func provideFavoriteMovie() -> FavoriteMovieUseCase {
        let repository = provideFavoriteMovieRepository()
        return FavoriteMovieInteractor(repository: repository)
    }
}
