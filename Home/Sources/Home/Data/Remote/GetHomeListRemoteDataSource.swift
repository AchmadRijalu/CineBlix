//
//  GetHomeListRemoteDataSource.swift
//  Home
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetHomeListRemoteDataSource: DataSource {

    public typealias Request = HomeListRequest
    public typealias Response = MoviesResponse

    public init() {}

    public func execute(request: HomeListRequest?) -> AnyPublisher<MoviesResponse, Error> {
        guard let request, let url = URL(string: request.endpointURL) else {
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
