//
//  GetSearchRemoteDataSource.swift
//  Search
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetSearchRemoteDataSource: DataSource {

    public typealias Request = SearchRequest
    public typealias Response = MoviesResponse

    public init() {}

    public func execute(request: SearchRequest?) -> AnyPublisher<MoviesResponse, Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        switch request {
        case .search(let endpointURL, _, _):
            guard let url = URL(string: endpointURL) else {
                return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
            }

            return Future<MoviesResponse, Error> { completion in
                AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
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
}
