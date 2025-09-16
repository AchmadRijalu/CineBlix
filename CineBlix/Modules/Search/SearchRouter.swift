//
//  SearchRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 10/08/25.
//

import SwiftUI

class SearchRouter {
    
    func createDetailMovie(movieId: Int) -> some View {
        let detailMovieUseCase = Injection.init().provideDetailMovie()
        let detailMoviePresenter = DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: movieId)
        return DetailMovieView(detailMoviePresenter: detailMoviePresenter).hideTabBar()
    }
}
