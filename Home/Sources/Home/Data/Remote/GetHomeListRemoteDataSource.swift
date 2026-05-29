//
//  GetHomeListRemoteDataSource.swift
//  Home
//
//  Created by Achmad Rijalu on 26/11/25.
//

import Core
import Alamofire
import Combine
import Foundation

public struct GetHomeListRemoteDataSource: DataSource {
    
    public typealias Request = Any
    
    public typealias Response = MoviesResponse
    
    private let _endPoint: String
    
    public init(_endPoint: String) {
        self._endPoint = _endPoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<MoviesResponse, any Error> {
        return Future<MoviesResponse, Error> { completion in
            if let url = URL(string: self._endPoint) {
                AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
