//
//  FavoriteView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI
import CommonKit

struct FavoriteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var favoritePresenter: FavoritePresenter
    var body: some View {
        VStack {
            GeneralToolBar(action: {
                dismiss()
            }, title: localization.Screen.Favorites.title)
            GeometryReader { geo in
                VStack {
                    ForEach(favoritePresenter.favoriteMovies, id: \.id) { movieData in
                        self.favoritePresenter.navigateToDetailMovie(movieId: movieData.id) {
                            FavoriteMovieItem(movieImage: movieData.posterPath, movieTitle: movieData.title, movieRatings: movieData.voteAverage) {
                                favoritePresenter.deleteFavoriteMovie(movieId: movieData.id)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            favoritePresenter.getAllFavoriteMovie()
        }
    }
}

#Preview {
    var presenter = FavoritePresenter(useCase: Injection.init().provideFavoriteMovie())
    FavoriteView(favoritePresenter: presenter)
}
