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
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                Image("wave").resizable().frame(width: UIScreen.main.bounds.width).ignoresSafeArea()
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        ScrollView(showsIndicators: false) {
                            BannerSectionView(homePresenter: homePresenter)
                                .padding(.bottom, 20)
                            NowPlaying(homePresenter: homePresenter)
                        }.padding(.bottom, 20)
                        .sheet(isPresented: $isProfileShowed) {
                            profilePresenter.navigateToProfile {}
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
                                homePresenter.navigateToFavoriteView(content: {
                                    Image(systemName: "bookmark.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundStyle(Color("SecondaryColor")).padding(4)
                                })
                                .buttonStyle(.borderedProminent)
                                .clipShape(Circle()).tint(.black)
                        }
                    }
                }
            }
        }.onAppear {
            homePresenter.getNowPlayingMovie(page: 1)
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
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .padding(.horizontal, 15)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 200)
            } else {
                TabView {
                    ForEach(homePresenter.movieTopRatedResultmodel, id: \.id) { movie in
                        HomeBannerComponent(movieImage: movie.posterPath)
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .padding(.horizontal, 15)
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
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Now Playing")
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .semibold))
            .padding(.bottom, 12)
            
            if homePresenter.nowPlayingLoadingState {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<6, id: \.self) { _ in
                        HomeListItemComponent(isSkeleton: homePresenter.nowPlayingLoadingState)
                            .frame(height: 200)
                    }
                }
                .padding(.horizontal, 10)
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
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
            }
        }
        .padding(.bottom, 24)
    }
}
