//
//  GetFavoriteRepository.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Combine
import Core

public struct GetFavoriteRepository: Repository {

    public typealias Request = FavoriteRequest
    public typealias Response = FavoriteResult

    private let localeDataSource: GetFavoriteLocaleDataSource
    private let transformer = FavoriteMovieTransformer()

    public init(localeDataSource: GetFavoriteLocaleDataSource) {
        self.localeDataSource = localeDataSource
    }

    public func execute(request: FavoriteRequest?) -> AnyPublisher<FavoriteResult, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        return localeDataSource.execute(request: request)
            .map { [transformer] response in
                switch (request, response) {
                case (.list, .list(let entities)):
                    return .movies(transformer.mapEntityToDomain(entities))
                case (.delete, .deleted(let success)):
                    return .deleted(success)
                default:
                    return .deleted(false)
                }
            }
            .eraseToAnyPublisher()
    }
}
