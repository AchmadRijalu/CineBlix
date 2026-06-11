//
//  GetSearchRepository.swift
//  Search
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core

public struct GetSearchRepository: Repository {

    public typealias Request = SearchRequest
    public typealias Response = SearchResult

    private let remoteDataSource: GetSearchRemoteDataSource
    private let transformer = SearchResultTransformer()

    public init(remoteDataSource: GetSearchRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func execute(request: SearchRequest?) -> AnyPublisher<SearchResult, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        switch request {
        case .search:
            return remoteDataSource.execute(request: request)
                .map { [transformer] response in
                    .movies(transformer.transformResponseToDomain(response: response.results))
                }
                .eraseToAnyPublisher()
        }
    }
}
