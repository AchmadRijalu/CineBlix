//
//  SearchView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 10/08/25.
//

import SwiftUI
import CommonKit

struct SearchMovieView: View {
    @ObservedObject var searchPresenter: SearchPresenter
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        NavigationView {
            searchContent
        }
        .navigationViewStyle(.stack)
    }

    private var searchContent: some View {
        GeometryReader { geometry in
            let topInset = geometry.safeAreaInsets.top
            let bottomInset = geometry.safeAreaInsets.bottom

            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                Image("wave")
                    .resizable()
                    .frame(width: geometry.size.width)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Text("Search Movies")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color("WhiteColor"))
                        Spacer()
                    }
                    .padding(.bottom, 8)

                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color("PrimaryColor"))
                            .font(.system(size: 16, weight: .semibold))

                        TextField(
                            "",
                            text: $searchPresenter.queryMovie,
                            prompt: Text("Search by movie title...")
                                .foregroundColor(.gray.opacity(0.8))
                        )
                        .focused($isSearchFocused)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.black)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .submitLabel(.search)

                        if !searchPresenter.queryMovie.isEmpty {
                            Button {
                                searchPresenter.queryMovie = ""
                                isSearchFocused = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.gray.opacity(0.6))
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color("WhiteColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                    .padding(.bottom, 16)

                    if searchPresenter.searchLoadingState {
                        Spacer()
                        ProgressView()
                            .tint(Color("WhiteColor"))
                            .scaleEffect(1.2)
                        Spacer()
                    } else if searchPresenter.queryMovie.trimmingCharacters(in: .whitespaces).isEmpty {
                        VStack(spacing: 16) {
                            Spacer()
                            Image(systemName: "film.stack")
                                .font(.system(size: 52))
                                .foregroundStyle(Color("WhiteColor").opacity(0.85))
                            Text("Discover Movies")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color("WhiteColor"))
                            Text("Type a movie name to start searching")
                                .font(.system(size: 15))
                                .foregroundStyle(Color("WhiteColor").opacity(0.75))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else if searchPresenter.searchMovieList.isEmpty {
                        VStack(spacing: 16) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundStyle(Color("WhiteColor").opacity(0.85))
                            Text("No Results Found")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color("WhiteColor"))
                            Text("Try a different keyword for \"\(searchPresenter.queryMovie)\"")
                                .font(.system(size: 15))
                                .foregroundStyle(Color("WhiteColor").opacity(0.75))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 12) {
                                ForEach(searchPresenter.searchMovieList, id: \.id) { movie in
                                    searchPresenter.navigateToDetailMovie(movieId: movie.id) {
                                        SearchMovieListItem(
                                            movieImage: movie.posterPath,
                                            movieTitle: movie.title,
                                            movieRatings: movie.voteAverage
                                        )
                                    }
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, topInset + 12)
                .padding(.bottom, bottomInset + 88)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SearchMovieView(
        searchPresenter: SearchPresenter(
            searchMovieUseCase: Injection().provideSearchMovie()
        )
    )
}
