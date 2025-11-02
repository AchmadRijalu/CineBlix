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
    func addFavoriteMovie(movieResultModel: MovieResultModel) -> AnyPublisher<Bool, Error>
    func removeFavoriteMovie(movieResult: MovieResultModel) -> AnyPublisher<Bool, Error>
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, Error>
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
    
    func addFavoriteMovie(movieResultModel: MovieResultModel) -> AnyPublisher<Bool, any Error> {
        return repository.addFavoriteMovie(movieResultModel: movieResultModel)
    }
    
    func removeFavoriteMovie(movieResult: MovieResultModel) -> AnyPublisher<Bool, any Error> {
        return repository.removeFavoriteMovie(movieResult: movieResult)
    }
    
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, any Error> {
        return repository.isFavoriteMovieExist(movieId: movieId)
    }
}
