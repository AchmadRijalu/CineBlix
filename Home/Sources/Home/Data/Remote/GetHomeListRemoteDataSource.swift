//
//  GetHomeListRemoteDataSource.swift
//  Home
//

import Core
import Alamofire
import Combine
import Foundation

public struct GetHomeListRemoteDataSource: DataSource {

    public typealias Request = HomeListRequest
    public typealias Response = MoviesResponse

    public init() {}

    public func execute(request: HomeListRequest?) -> AnyPublisher<MoviesResponse, any Error> {
        guard let request, let url = URL(string: request.endpointURL) else {
            return Fail(error: URLError.invalidResponse).eraseToAnyPublisher()
        }

        return Future<MoviesResponse, Error> { completion in
            AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure:
                    completion(.failure(URLError.invalidResponse))
                }
            }
        }.eraseToAnyPublisher()
    }
}
