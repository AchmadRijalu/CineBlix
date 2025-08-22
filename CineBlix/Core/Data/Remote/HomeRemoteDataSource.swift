//
//  RemoteDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//

import Foundation
import Alamofire
import Combine
import SwiftyJSON

protocol HomeRemoteDataSourceProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
    func getPopularMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
}

class HomeRemoteDataSource: NSObject {
    override init() {}
    static let sharedInstance: HomeRemoteDataSource = HomeRemoteDataSource()
}

extension HomeRemoteDataSource: HomeRemoteDataSourceProtocol {

    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error> {
        let endpoint = Endpoints.Gets.movieNowPlaying(page: page)
        let url = endpoint.url
        let header = APICall.headers
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: header).validate().responseData { response in
                switch response.result {
                case .success(let movieData):
                    let responseData = JSON(movieData)
                    let movieResponse = MoviesResponse(json: responseData)
                    let movieResults = movieResponse.results
                    completion(.success(movieResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], any Error> {
        let endpoint = Endpoints.Gets.moviePopular(page: page)
        let url = endpoint.url
        let header = APICall.headers
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: header).validate().responseData { response in
                switch response.result {
                case .success(let movieData):
                    let responseData = JSON(movieData)
                    let movieResponse = MoviesResponse(json: responseData)
                    let movieResults = movieResponse.results
                    completion(.success(movieResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getUpcomingMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], any Error> {
        let endpoint = Endpoints.Gets.movieUpcoming(page: page)
        let url = endpoint.url
        let header = APICall.headers
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: header).validate().responseData { respose in
                switch respose.result {
                case .success(let movieData):
                    let responseData = JSON(movieData)
                    let movieResponse = MoviesResponse(json: responseData)
                    let movieResults = movieResponse.results
                    completion(.success(movieResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], any Error> {
        let endpoint = Endpoints.Gets.movieTopRated(page: page)
        let url = endpoint.url
        let header = APICall.headers
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: header).validate().responseData { respose in
                switch respose.result {
                case .success(let movieData):
                    let responseData = JSON(movieData)
                    let movieResponse = MoviesResponse(json: responseData)
                    let movieResults = movieResponse.results
                    completion(.success(movieResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
