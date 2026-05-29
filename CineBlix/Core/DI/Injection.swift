//
//  Injection.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation
import RealmSwift
import Core
import Home
import UIKit

final class Injection: NSObject {

    private let realm = try? Realm()

    func provideHome() -> HomeUseCase {
        let locale = GetHomeListLocaleDataSource(_realm: realm!)
        let remote = GetHomeListRemoteDataSource()
        let mapper = MovieResultTransformer()
        let repository = GetHomeListRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper
        )
        let listUseCase = Interactor(repository: repository)
        return HomeInteractor(listUseCase: listUseCase)
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
