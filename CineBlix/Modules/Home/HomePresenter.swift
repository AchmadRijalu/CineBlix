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
        guard movieNowPlayingResultsModel.isEmpty else { return }
        nowPlayingLoadingState = true
        homeUseCase.getNowPlayingMovies(page: page).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.nowPlayingLoadingState = false
            case .failure(let error):
                self.errorMessage = String(describing: completion)
                self.router.presentGeneralError(errorMessage: self.errorMessage)
            }
        } receiveValue: { movieModel in
            self.movieNowPlayingResultsModel = movieModel
        }.store(in: &cancellables)
    }
    
    func getPopularMovie(page: Int) {
        guard moviePopularResultsModel.isEmpty else {return}
        upcomingLoadingState = true
        homeUseCase.getPopularMovies(page: page).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.upcomingLoadingState = false
            case .failure(let error):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { movieModel in
            self.moviePopularResultsModel = movieModel
        }.store(in: &cancellables)
    }
    
    func getUpComingMovie(page: Int) {
        guard movieUpcomingResultsModel.isEmpty else {return}
        popularLoadingState = true
        homeUseCase.getUpcomingMovies(page: page).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.popularLoadingState = false
            case .failure(let error):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { movieModel in
            self.movieUpcomingResultsModel = movieModel
        }.store(in: &cancellables)
    }
    
    func getTopRatetdMovie(page: Int) {
        guard movieTopRatedResultmodel.isEmpty else {return}
        topRatedLoadingState = true
        homeUseCase.getTopRatedMovies(page: page).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.topRatedLoadingState = false
            case .failure(let error):
                self.errorMessage = String(describing: completion)
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
    
    func navigateToFavoriteView() -> some View {
        router.createFavoriteMovieView()
    }
}
