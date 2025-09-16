//
//  SearchMovieRepository.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 10/09/25.
//

import Combine

protocol SearchMovieRepositoryProtocol{
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], Error>
}

class SearchMovieRepository: SearchMovieRepositoryProtocol {
    
    typealias MovieInstance = (SearchMovieRemoteDataSource) -> SearchMovieRepository
    
    fileprivate let remote: SearchMovieRemoteDataSource
    
    private init(remote: SearchMovieRemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { remote in
        return SearchMovieRepository(remote: remote)
    }
}

extension SearchMovieRepository {
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], any Error> {
        remote.fetchSearchMovie(query: query, page: page).map { response in
            SearchMovieMapper.mapSearchMovieResponseToDomains(input: response)
        }.eraseToAnyPublisher()
    }
}
