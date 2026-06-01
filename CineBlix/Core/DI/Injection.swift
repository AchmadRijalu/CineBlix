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
import Search
import DetailMovie
import Favorite
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

    func provideSearchMovie() -> SearchMovieUserCase {
        let repository = GetSearchRepository(
            remoteDataSource: GetSearchRemoteDataSource()
        )
        return SearchMovieInteractor(useCase: Interactor(repository: repository))
    }

    func provideDetailMovie() -> DetailMovieUseCase {
        let repository = GetDetailMovieRepository(
            remoteDataSource: GetDetailMovieRemoteDataSource(),
            localeDataSource: DetailMovieFavoriteLocalDataSource(realm: realm!)
        )
        return DetailMovieInteractor(useCase: Interactor(repository: repository))
    }

    func provideFavoriteMovie() -> FavoriteMovieUseCase {
        let repository = GetFavoriteRepository(
            localeDataSource: GetFavoriteLocaleDataSource(realm: realm!)
        )
        return FavoriteMovieInteractor(useCase: Interactor(repository: repository))
    }
}
