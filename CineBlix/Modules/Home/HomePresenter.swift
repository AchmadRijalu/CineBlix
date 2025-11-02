//
//  HomePresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation
import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    private let router =  HomeRouter()
    private let homeUseCase: HomeUseCase
    private var cancellables : Set<AnyCancellable> = []
    
    @Published var movieNowPlayingResultsModel: [MovieResultModel] = []
    @Published var moviePopularResultsModel: [MovieResultModel] = []
    @Published var movieUpcomingResultsModel: [MovieResultModel] = []
    @Published var movieTopRatedResultmodel: [MovieResultModel] = []
    @Published var errorMessage: String = ""
    @Published var nowPlayingLoadingState: Bool = false
    @Published var upcomingLoadingState: Bool = false
    @Published var popularLoadingState: Bool = false
    @Published var topRatedLoadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getNowPlayingMovie(page: Int) {
        nowPlayingLoadingState = true
        homeUseCase.getNowPlayingMovies(page: page).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.nowPlayingLoadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
                self.router.presentGeneralError(errorMessage: self.errorMessage)
            }
        } receiveValue: { movieModel in
            self.movieNowPlayingResultsModel = movieModel
        }.store(in: &cancellables)
    }
    
    func getTopRatetdMovie(page: Int) {
        topRatedLoadingState = true
        homeUseCase.getTopRatedMovies(page: page).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.topRatedLoadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
                self.router.presentGeneralError(errorMessage: self.errorMessage)
            }
        } receiveValue: { movieModel in
            self.movieTopRatedResultmodel = movieModel
        }.store(in: &cancellables)

    }
    
    //MARK: - Router
    func navigateToDetailView<Content: View>(with id: Int, @ViewBuilder content: () -> Content ) -> some View {
        NavigationLink(destination: router.createDetailMovieView(movieId: id)) {
            content()
        }
    }
    
    func navigateToFavoriteView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.createFavoriteMovieView()) {
            content()
            
        }
    }
}
