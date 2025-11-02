//
//  DetailMoviePresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation
import Combine
import SwiftUI
import SkeletonUI

enum DetailMovieContent: CaseIterable, Identifiable{
    var id: Self {self}
    case movieInfo
    case movieReview
    
    var title: String {
        switch self {
        case .movieInfo:
            return "Info"
        case .movieReview:
            return "Review"
        }
    }
}

class DetailMoviePresenter: ObservableObject {
    private let router = DetailMovieRouter()
    private let detailMovieUseCase: DetailMovieUseCase
    private var cancellables: Set<AnyCancellable> = []
    let movieId: Int
    
    @Published var detailMovieModel: DetailMovieModel?
    @Published var detailMovieReviewModel: [DetailMovieReviewModel]?
    @Published var detailMovieVideoModel: [DetailMovieVideoModel]?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavorite: Bool = false
    
    init(detailMovieUseCase: DetailMovieUseCase, movieId: Int) {
        self.detailMovieUseCase = detailMovieUseCase
        self.movieId = movieId
        self.getDetailMovie()
        self.getDetailMovieVideos(movieId: movieId)
    }
    
    func getDetailMovie() {
        loadingState = true
        detailMovieUseCase.getDetailMovieInfo(movieId: movieId).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.router.presentGeneralError(errorMessage: self.errorMessage)
            }
        } receiveValue: { response in
            self.detailMovieModel = response
        }.store(in: &cancellables)
    }
    
    func getDetailMovieReviews(movieId: Int) {
        loadingState = true
        detailMovieUseCase.getDetailMovieReviews(movieId: movieId).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } receiveValue: { response in
            self.detailMovieReviewModel = response
        }.store(in: &cancellables)
    }
    
    func getDetailMovieVideos(movieId: Int) {
        loadingState = true
        detailMovieUseCase.getDetailMovieVideos(movieId: movieId).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } receiveValue: { response in
            self.detailMovieVideoModel = response
        }.store(in: &cancellables)

    }
    
    func toggleFavorite(detailMovieModel: DetailMovieModel) {
        if isFavorite {
            deleteMovieFromFavorite(detailMovieModel: detailMovieModel)
        } else {
            addMovieToFavorite(detailMovieModel: detailMovieModel)
        }
    }
    
    func addMovieToFavorite(detailMovieModel: DetailMovieModel) {
        let movieResultModel = MovieResultModel(
            id: movieId,
            posterPath: detailMovieModel.posterPath,
            title: detailMovieModel.title,
            voteAverage: detailMovieModel.voteAverage,
            addedAt: Date()
        )
        
        detailMovieUseCase.addFavoriteMovie(movieResultModel: movieResultModel).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❌ Failed to add favorite:", error.localizedDescription)
                }
            }, receiveValue: { success in
                self.isFavorite = true
            })
            .store(in: &cancellables)
    }

    func deleteMovieFromFavorite(detailMovieModel: DetailMovieModel) {
        let movieResultModel = MovieResultModel(
            id: movieId,
            posterPath: detailMovieModel.posterPath,
            title: detailMovieModel.title,
            voteAverage: detailMovieModel.voteAverage,
            addedAt: nil
        )
        
        detailMovieUseCase.removeFavoriteMovie(movieResult: movieResultModel).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(_) = completion {}
            }, receiveValue: { success in
                self.isFavorite = false
            })
            .store(in: &cancellables)
    }
    
    func checkIsFavoriteMovie(movieId: Int) {
        detailMovieUseCase.isFavoriteMovieExist(movieId: movieId).receive(on: DispatchQueue.main).sink { _ in } receiveValue: { isFavorite in
            self.isFavorite = isFavorite
        }.store(in: &cancellables)
    }

}

extension DetailMoviePresenter {
    func convertToHoursFromMinutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return "\(hours)h \(remainingMinutes)m"
    }
}
