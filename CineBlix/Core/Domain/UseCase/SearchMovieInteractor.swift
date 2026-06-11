//
//  SearchMovieInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core
import Search

protocol SearchMovieUserCase {
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], Error>
}

typealias SearchUseCaseInteractor = Interactor<
    SearchRequest,
    SearchResult,
    GetSearchRepository
>

final class SearchMovieInteractor: SearchMovieUserCase {

    private let useCase: SearchUseCaseInteractor

    init(useCase: SearchUseCaseInteractor) {
        self.useCase = useCase
    }

    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], Error> {
        useCase.execute(
            request: .search(
                endpointURL: Endpoints.Gets.searchMovie(query: query, page: page).url,
                query: query,
                page: page
            )
        )
        .tryMap { result in
            guard case .movies(let models) = result else {
                throw Core.URLError.invalidResponse
            }
            return models
        }
        .eraseToAnyPublisher()
    }
}
