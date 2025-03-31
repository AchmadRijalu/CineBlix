//
//  HomePresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation
import SwiftUI
import RxSwift


class HomePresenter: ObservableObject {
    private let router = DetailMovieRouter()
    private let homeUseCase: HomeUseCase
    private let disposeBag: DisposeBag = DisposeBag()
    
    
    @Published var movieNowPlayingList: [MovieNowPlayingResultModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func linkBuilder<Content: View>(
        @ViewBuilder content: () -> Content ) -> some View {
        NavigationLink(destination: router.createDetailMovieView()) {
            content()
        }
    }
    
    //MARK: - Fetching Now Playing Movie
    
    func getNowPlayingMovie() {
        loadingState = true
        homeUseCase.getNowPlayingMovies().observe(on: MainScheduler.instance).subscribe { result in
            self.movieNowPlayingList = result
        } onError: { error in
            self.errorMessage = error.localizedDescription
        } onCompleted: {
            self.loadingState = false
        }.disposed(by: disposeBag)
    }
}
