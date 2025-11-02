//
//  FavoriteRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 03/11/24.
//

import SwiftUI

class FavoriteRouter {
    func createDetailMovieView(movieId: Int) -> some View {
        let detailMovieUseCase = Injection.init().provideDetailMovie()
        let detailMoviePresenter = DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: movieId)
        return DetailMovieView(detailMoviePresenter: detailMoviePresenter).hideTabBar()
    }
}
