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
    
    init(detailMovieUseCase: DetailMovieUseCase, movieId: Int) {
        self.detailMovieUseCase = detailMovieUseCase
        self.movieId = movieId
        getDetailMovie()
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
    
    func addMovieToFavorite(detailMovieModel: DetailMovieModel) {
        
    }
}

extension DetailMoviePresenter {
    func convertToHoursFromMinutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return "\(hours)h \(remainingMinutes)m"
    }
}
