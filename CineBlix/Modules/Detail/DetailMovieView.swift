//
//  DetailMovieView.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//

import SwiftUI
import Combine
import YouTubePlayerKit
import Kingfisher

struct DetailMovieView: View {
    @State var isFavorite: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var isShowMovieWebsite = false
    @StateObject var detailMoviePresenter: DetailMoviePresenter
    @State private var selectedContent: DetailMovieContent = .movieInfo
    @State private var youTubePlayer = YouTubePlayer()
    @State private var isDetailMovieInfoLoaded: Bool = false
    @State private var isDetailMovieReviewsLoaded: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("PrimaryColor")
                VStack {
                    MovieVideoHeaderView(
                        detailMoviePresenter: detailMoviePresenter,
                        youTubePlayer: youTubePlayer
                    ) {
                        dismiss()
                    } favoriteAction: {
                        if let model = detailMoviePresenter.detailMovieModel {
                            detailMoviePresenter.addMovieToFavorite(detailMovieModel: model)
                        }
                    }
                    Picker("Content", selection: $selectedContent) {
                        ForEach(DetailMovieContent.allCases) { content in
                            Text(content.title).tag(content)
                        }
                    }
                    .pickerStyle(.segmented).padding(.bottom, 24).padding(.horizontal, 24)
                    switch selectedContent {
                    case .movieInfo:
                        DetailMovieInfoSection(detailMoviePresenter: detailMoviePresenter, isShowMovieWebsite: $isShowMovieWebsite)
                    case .movieReview:
                        VStack {
                            DetailmovieReviewSection(detailMoviePresenter: detailMoviePresenter).padding(.horizontal)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onAppear {
                                if isDetailMovieReviewsLoaded == false {
                                    detailMoviePresenter.getDetailMovieReviews(movieId: detailMoviePresenter.movieId)
                                    self.isDetailMovieReviewsLoaded = true
                                }
                            }
                    }
                }
            }.sheet(isPresented: $isShowMovieWebsite, content: {
                VStack {
                    HStack {
                        Image(systemName: "chevron.backward").foregroundColor(.white).padding(.leading, 12)
                        Text("Back").font(.system(.title3)).foregroundColor(.white).onTapGesture {
                            isShowMovieWebsite.toggle()
                        }
                        Spacer()
                    }.padding(.top, 8)
                    GeneralWebview(urlString: detailMoviePresenter.detailMovieModel?.homePageLink ?? "")
                }.background(Color("PrimaryColor"))
                
            })
            .ignoresSafeArea()
        }.background(Color("PrimaryColor")).navigationBarBackButtonHidden(true)
            .onReceive(detailMoviePresenter.$detailMovieVideoModel) { newValue in
                let keys = newValue?.map { $0.movieVideoKey } ?? []
                if !keys.isEmpty {
                    Task {
                        try await youTubePlayer.load(source: .video(id: keys.first ?? ""))
                    }
                }
            }.onAppear {
                detailMoviePresenter.checkIsFavoriteMovie(movieId: detailMoviePresenter.movieId)
            }
    }
}

struct MovieVideoHeaderView: View {
    @ObservedObject var detailMoviePresenter: DetailMoviePresenter
    let youTubePlayer: YouTubePlayer
    var dismissAction: () -> Void
    var favoriteAction: () -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                YouTubePlayerView(youTubePlayer) { state in
                    switch state {
                    case .idle:
                        KFImage.url(
                            URL(string: Endpoints.Gets.image(
                                imageFilePath: detailMoviePresenter.detailMovieModel?.backdropPath ?? ""
                            ).url)
                        )
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .skeleton(with: detailMoviePresenter.loadingState, shape: .rectangle)
                    case .ready:
                        EmptyView()
                    case .error:
                        EmptyView()
                    }
                }
                HStack {
                    Button(action: dismissAction) {
                        Image(systemName: "chevron.backward")
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(.circle)
                    .tint(.white)
                    .foregroundStyle(.black)
                    .padding()
                    .padding(.top, 32)
                    
                    Spacer()
                    
                    Button(action: {
                        guard let detailMovieModel = detailMoviePresenter.detailMovieModel else { return }
                        detailMoviePresenter.toggleFavorite(detailMovieModel: detailMovieModel)
                    }) {
                        Image(systemName: detailMoviePresenter.isFavorite ? "bookmark.fill" : "bookmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(.circle)
                    .tint(.white)
                    .foregroundStyle(.black)
                    .padding()
                    .padding(.top, 32)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 240)
        .background(.clear)
        .padding(.bottom, 12)
    }
}


#Preview {
    var detailMovieUseCase = Injection.init().provideDetailMovie()
    DetailMovieView(detailMoviePresenter: DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: 912649))
}
