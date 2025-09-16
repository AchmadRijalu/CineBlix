//
//  SearcMovieRemoteDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 11/09/25.
//

import Alamofire
import Combine
import SwiftyJSON

protocol SearchMovieRemoteDataSourceProtocol: AnyObject {
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
}

class SearchMovieRemoteDataSource: SearchMovieRemoteDataSourceProtocol {
    
    static let sharedInstance = SearchMovieRemoteDataSource()
    init(){}
}

extension SearchMovieRemoteDataSource {
    func fetchSearchMovie(query: String, page: Int) -> AnyPublisher<[MoviesResultResponse],  Error> {
        let endPoint = Endpoints.Gets.searchMovie(query: query, page: page)
        let header = APICall.headers
        let url = endPoint.url
        
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: header).validate().responseData { response in
                switch response.result {
                case .success(let searchMovieResponse):
                    let searchMovieResponseData = JSON(searchMovieResponse)
                    let searchMovieData = MoviesResponse(json: searchMovieResponseData)
                    completion(.success(searchMovieData.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

