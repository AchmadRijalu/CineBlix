//
//  HomeView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 09/09/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var profilePresenter: ProfilePresenter
    @ObservedObject var homePresenter: HomePresenter
    
    @State var isProfileShowed: Bool = false
    @State var showFavoriteSheet: Bool = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                Image("wave").resizable().frame(width: UIScreen.main.bounds.width).ignoresSafeArea()
                GeometryReader { geo in
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search movies...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(10)
                        .background(Color("SecondaryColor"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.black).padding(.vertical, 12)
                        ScrollView(showsIndicators: false){
                            BannerSectionView(homePresenter: homePresenter).onAppear {
                                self.homePresenter.getTopRatetdMovie(page: 1)
                            }
                            NowPlaying(homePresenter: homePresenter)
                                .onAppear {
                                    self.homePresenter.getNowPlayingMovie(page: 1)
                                }
                            UpcomingSection(homePresenter: homePresenter)
                                .onAppear {
                                    self.homePresenter.getUpComingMovie(page: 1)
                                }
                            PopularSection(homePresenter: homePresenter)
                                .onAppear {
                                    self.homePresenter.getPopularMovie(page: 1)
                                }
                        }.sheet(isPresented: $isProfileShowed) {
                            profilePresenter.navigateToProfile {}
                        }.fullScreenCover(isPresented: $showFavoriteSheet) {} content: {
                            self.homePresenter.navigateToFavoriteView()
                        }
                        
                    }.padding(10).frame(maxWidth: geo.size.width, maxHeight:  geo.size.height)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    isProfileShowed = true
                                } label: {
                                    Image("image-profile")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())
                                    
                                }
                                .buttonStyle(.borderless)
                                .clipShape(Circle()).tint(.black)
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showFavoriteSheet.toggle()
                                } label: {
                                    Image(systemName: "bookmark.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundStyle(Color("SecondaryColor")).padding(4)
                                }
                                .buttonStyle(.borderedProminent)
                                .clipShape(Circle()).tint(.black)
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Banner
struct BannerSectionView: View {
    @ObservedObject var homePresenter: HomePresenter
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: 20) {
                    ForEach((1...10), id: \.self) { _ in
                        HomeBannerComponent(imageName: "a")
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: 200).padding(.bottom, 24).padding(.top, 8)
    }
}

//MARK: - Now Playing
struct NowPlaying: View {
    @ObservedObject var homePresenter: HomePresenter
    var body: some View {
        HStack{
            Text("Now Playing")
            Spacer()
        }.foregroundStyle(.white).font(.system(size: 20, weight: .semibold)).padding(.bottom, 12)
        
        VStack {
            if homePresenter.nowPlayingLoadingState {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { _ in
                            HomeListItemComponent(isSkeleton: true)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 200)
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(self.homePresenter.movieNowPlayingResultsModel, id: \.id) { movieNowPlayingResultsModel in
                            self.homePresenter.navigateToDetailView(with: movieNowPlayingResultsModel.id) {
                                HomeListItemComponent(
                                    movieImage: movieNowPlayingResultsModel.posterPath,
                                    movieRatings: movieNowPlayingResultsModel.voteAverage,
                                    movieTitle: movieNowPlayingResultsModel.title
                                )
                                .frame(height: 200)
                            }
                        }
                    }
                    .frame(height: 200)
                    .padding(.horizontal, 10)
                }
            }
        }
        .padding(.bottom, 24)
    }
}

//MARK: - Upcoming
struct UpcomingSection: View {
    @ObservedObject var homePresenter: HomePresenter
    var body: some View {
        HStack{
            Text("Upcoming Movies")
            Spacer()
        }.foregroundStyle(.white).font(.system(size: 20, weight: .semibold)).padding(.bottom, 12)
        VStack {
            if homePresenter.nowPlayingLoadingState {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { _ in
                            HomeListItemComponent(isSkeleton: true)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 200)
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(self.homePresenter.movieUpcomingResultsModel, id: \.id) { movieNowPlayingResultsModel in
                            self.homePresenter.navigateToDetailView(with: movieNowPlayingResultsModel.id) {
                                HomeListItemComponent(movieImage: movieNowPlayingResultsModel.posterPath, movieRatings: movieNowPlayingResultsModel.voteAverage, movieTitle: movieNowPlayingResultsModel.title)
                            }
                        }
                    }.frame(height: 200)
                        .padding(.bottom, 10)
                }
            }
        }.padding(.bottom, 24)
    }
}

//MARK: - Popular
struct PopularSection: View {
    @ObservedObject var homePresenter: HomePresenter
    var body: some View {
        HStack{
            Text("Popular")
            Spacer()
        }.foregroundStyle(.white).font(.system(size: 20, weight: .semibold)).padding(.bottom, 12)
        VStack {
            if homePresenter.nowPlayingLoadingState {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { _ in
                            HomeListItemComponent(isSkeleton: true)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 200)
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(self.homePresenter.moviePopularResultsModel, id: \.id) { movieNowPlayingResultsModel in
                            self.homePresenter.navigateToDetailView(with: movieNowPlayingResultsModel.id) {
                                HomeListItemComponent(movieImage: movieNowPlayingResultsModel.posterPath, movieRatings: movieNowPlayingResultsModel.voteAverage, movieTitle: movieNowPlayingResultsModel.title)
                            }
                        }
                    }.frame(height: 200)
                        .padding(.bottom, 10)
                }
            }
        }.padding(.bottom, 24)
    }
}

