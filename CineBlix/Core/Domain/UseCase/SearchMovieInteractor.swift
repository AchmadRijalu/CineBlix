//
//  SearchMovieInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/08/25.
//

import Combine

protocol SearchMovieUserCase {
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], Error>
}

class SearchMovieInteractor: SearchMovieUserCase {
    
    private let repository: SearchMovieRepositoryProtocol
    
    init(repository: SearchMovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], any Error> {
        return repository.fetchSearchMovie(query: query, page: page)
    }
}
