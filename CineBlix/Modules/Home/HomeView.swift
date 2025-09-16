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
                        ScrollView(showsIndicators: false){
                            BannerSectionView(homePresenter: homePresenter).onAppear {
                                self.homePresenter.getTopRatetdMovie(page: 1)
                            }
                            NowPlaying(homePresenter: homePresenter)
                            UpcomingSection(homePresenter: homePresenter)
                            PopularSection(homePresenter: homePresenter)

                        }.sheet(isPresented: $isProfileShowed) {
                            profilePresenter.navigateToProfile {}
                        }.fullScreenCover(isPresented: $showFavoriteSheet) {} content: {
                            self.homePresenter.navigateToFavoriteView()
                        }
                        
                    }
                    .padding(10).frame(maxWidth: geo.size.width, maxHeight:  geo.size.height)
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
        }.onAppear {
            homePresenter.getNowPlayingMovie(page: 1)
            homePresenter.getUpComingMovie(page: 1)
            homePresenter.getPopularMovie(page: 1)
        }
    }
}

//MARK: - Banner
struct BannerSectionView: View {
    @ObservedObject var homePresenter: HomePresenter
    
    var body: some View {
        VStack {
            if homePresenter.topRatedLoadingState {
                TabView {
                    ForEach(0..<4, id: \.self) { _ in
                        HomeBannerComponent(isSkeleton: true)
                            .frame(width: UIScreen.main.bounds.width * 0.8) // smaller than screen
                            .padding(.horizontal, 20) // spacing between banners
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 200)
            } else {
                TabView {
                    ForEach(homePresenter.movieTopRatedResultmodel, id: \.id) { movie in
                        HomeBannerComponent(movieImage: movie.posterPath)
                            .frame(width: UIScreen.main.bounds.width * 0.8) // peek effect
                            .padding(.horizontal, 20)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 200)
            }
        }
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
                            HomeListItemComponent(isSkeleton: homePresenter.nowPlayingLoadingState)
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
            if homePresenter.upcomingLoadingState {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { _ in
                            HomeListItemComponent(isSkeleton: homePresenter.upcomingLoadingState)
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
            if homePresenter.popularLoadingState {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { _ in
                            HomeListItemComponent(isSkeleton: homePresenter.popularLoadingState)
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

