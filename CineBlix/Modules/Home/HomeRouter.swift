//
//  HomeRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/07/25.
//

import SwiftUI

class HomeRouter {

    func createDetailMovieView(movieId: Int) -> some View {
        let detailMovieUseCase = Injection.init().provideDetailMovie()
        let detailMoviePresenter = DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: movieId)
        return DetailMovieView(detailMoviePresenter: detailMoviePresenter).hideTabBar()
    }
    
    func createFavoriteMovieView() -> some View {
        let favoriteMovieUseCase = Injection.init().provideFavoriteMovie()
        let favoriteMoviePresenter = FavoritePresenter(useCase: favoriteMovieUseCase)
        return FavoriteView(favoritePresenter: favoriteMoviePresenter).hideTabBar()
    }
    
    func presentGeneralError(errorMessage: String) {
        ErrorBottomSheetPresenter.present(title: "Error", message: errorMessage)
    }
}
