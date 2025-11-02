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
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: HomeRepositoryProtocol
    
     init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getNowPlayingMovies(page: page)
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], any Error> {
        return repository.getTopRatedMovies(page: page)
    }
}
