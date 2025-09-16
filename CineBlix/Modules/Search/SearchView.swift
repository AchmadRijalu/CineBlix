//
//  SearchView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 10/08/25.
//

import SwiftUI

struct SearchMovieView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @ObservedObject var searchPresenter: SearchPresenter
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Text("Search Movies")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(.top, 24)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("", text: $searchPresenter.queryMovie, prompt: Text("Search Movies").foregroundColor(.gray))
                            .textFieldStyle(.plain)
                    }
                    .padding(10)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .padding(.vertical, 12)
                    
                    ScrollView(showsIndicators: false) {
                        if searchPresenter.searchLoadingState {
                            ProgressView()
                                .tint(Color("PrimaryColor"))
                                .padding(.top, 50)
                        } else {
                            LazyVStack(spacing: 12) {
                                ForEach(searchPresenter.searchMovieList, id: \.id) { searchMovie in
                                    searchPresenter.navigateToDetailMovie(movieId: searchMovie.id) {
                                        SearchMovieListItem(
                                            movieImage: searchMovie.posterPath,
                                            movieTitle: searchMovie.title,
                                            movieRatings: searchMovie.voteAverage)
                                    }
                                }
                            }
                            .padding(.horizontal, 4)
                            .padding(.bottom, 100)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let searchMovieUseCase = Injection.init().provideSearchMovie()
    SearchMovieView(searchPresenter: SearchPresenter(searchMovieUseCase: searchMovieUseCase))
}
