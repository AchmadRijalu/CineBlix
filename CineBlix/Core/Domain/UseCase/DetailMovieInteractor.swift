//
//  DetailMovieInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//

import Combine

protocol DetailMovieUseCase: AnyObject {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, Error>
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], Error>
    func getDetailMovieVideos(movieId: Int) -> AnyPublisher<[DetailMovieVideoModel], Error>
}

class DetailMovieInteractor: DetailMovieUseCase {
    
    private let repository: DetailMovieRepositoryProtocol
    
    init(repository: DetailMovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return repository.getDetailMovieInfo(movieId: movieId)
    }
    
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], any Error> {
        return repository.getDetailMovieReviews(movieId: movieId)
    }
    
    func getDetailMovieVideos(movieId: Int) -> AnyPublisher<[DetailMovieVideoModel], any Error> {
        return repository.getDetailMovieTrailers(movieId: movieId)
    }
}
