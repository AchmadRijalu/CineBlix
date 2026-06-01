//
//  GetDetailMovieRemoteDataSource.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetDetailMovieRemoteDataSource: DataSource {

    public typealias Request = DetailMovieRequest
    public typealias Response = DetailMovieRemoteResponse

    public init() {}

    public func execute(request: DetailMovieRequest?) -> AnyPublisher<DetailMovieRemoteResponse, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        switch request {
        case .info(let endpointURL):
            return fetch(url: endpointURL, as: DetailMovieResponse.self)
                .map { .info($0) }
                .eraseToAnyPublisher()
        case .reviews(let endpointURL):
            return fetch(url: endpointURL, as: DetailMovieReviewResponse.self)
                .map { .reviews($0) }
                .eraseToAnyPublisher()
        case .videos(let endpointURL):
            return fetch(url: endpointURL, as: DetailMovieVideoResponse.self)
                .map { .videos($0) }
                .eraseToAnyPublisher()
        case .addFavorite, .removeFavorite, .isFavoriteExist:
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }
    }

    private func fetch<T: Decodable & Sendable>(
        url endpointURL: String,
        as type: T.Type
    ) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpointURL) else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        return Future<T, Error> { completion in
            AF.request(url).validate().responseDecodable(of: type) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure:
                    completion(.failure(Core.URLError.invalidResponse))
                }
            }
        }.eraseToAnyPublisher()
    }
}
