//
//  HomeInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: MovieRepositoryProtocol
    
     init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getNowPlayingMovies(page: page)
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getPopularMovies(page: page)
    }
    
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getUpcomingMovies(page: page)
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getTopRatedMovies(page: page)
    }
    
}
