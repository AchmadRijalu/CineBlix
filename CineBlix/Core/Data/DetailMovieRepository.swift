//
//  DetailMovieRespository.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 16/07/25.
//

import Combine

protocol DetailMovieRepositoryProtocol: AnyObject {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, Error>
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], Error>
    func getDetailMovieTrailers(movieId: Int) -> AnyPublisher<[DetailMovieVideoModel], Error>
    func addFavoriteMovie(movieResultModel: MovieResultModel) -> AnyPublisher<Bool, Error>
    func removeFavoriteMovie(movieResult: MovieResultModel) -> AnyPublisher<Bool, Error>
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, Error>
}

class DetailMovieRepository {
    typealias DetailMovieInstance = (DetailMovieRemoteDataSource, DetailMovieLocalDataSource) -> DetailMovieRepository
    
    fileprivate var remoteDataSource: DetailMovieRemoteDataSource
    fileprivate var localDataSource: DetailMovieLocalDataSource
    
    init(remoteDataSource: DetailMovieRemoteDataSource, localDataSource: DetailMovieLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    //MARK: - The instance for injection parse data
    static let sharedInstance: (DetailMovieInstance) = { remoteDataSource, localDataSource in
        return DetailMovieRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
    }
}

extension DetailMovieRepository: DetailMovieRepositoryProtocol {
    
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, any Error> {
        return remoteDataSource.getDetailMovieInfo(movieId: movieId).map { response in
            DetailMovieMapper.mapDetailMovieResponseToModel(input: response)
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], any Error> {
        return remoteDataSource.getDetailMovieReviews(movieId: movieId).map { response in
            DetailMovieMapper.mapDetailMovieReviewsResponseToModel(input: response)
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovieTrailers(movieId: Int) -> AnyPublisher<[DetailMovieVideoModel], any Error> {
        return remoteDataSource.getDetailMovieVideos(movieId: movieId).map { response in
            DetailMovieMapper.mapDetailMovieVideoToModel(input: response)
        }.eraseToAnyPublisher()
    }
    
    func addFavoriteMovie(movieResultModel: MovieResultModel) -> AnyPublisher<Bool, any Error> {
        return localDataSource.addMovieToFavorite(movieResultModel).eraseToAnyPublisher()
    }
    
    func removeFavoriteMovie(movieResult: MovieResultModel) -> AnyPublisher<Bool, any Error> {
        return localDataSource.deleteMovieFromFavorite(movieResult).eraseToAnyPublisher()
    }
    
    func isFavoriteMovieExist(movieId: Int) -> AnyPublisher<Bool, any Error> {
        return localDataSource.isFavoriteMovieExist(movieId: movieId)
    }
}
