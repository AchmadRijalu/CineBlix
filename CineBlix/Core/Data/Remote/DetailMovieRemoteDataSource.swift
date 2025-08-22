//
//  DetailMovieRemoteDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 16/07/25.
//

import Foundation
import Alamofire
import Combine
import SwiftyJSON

protocol DetailMovieRemoteDataSourceProtocol: AnyObject {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieResponse, Error>
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<DetailMovieReviewResponse, Error>
    func getDetailMovieVideos(movieId: Int) -> AnyPublisher<DetailMovieVideoResponse, Error>
}

class DetailMovieRemoteDataSource: NSObject {
    static let shared = DetailMovieRemoteDataSource()
    override init() {}
}

extension DetailMovieRemoteDataSource: DetailMovieRemoteDataSourceProtocol {
    
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieResponse, any Error> {
        let endpoint = Endpoints.Gets.movieInfo(movieId: movieId)
        let url = endpoint.url
        let headers = APICall.headers
        return Future<DetailMovieResponse, Error> { completion in
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let responseData = JSON(data)
                    let detailMovieResponse = DetailMovieResponse(json: responseData)
                    completion(.success(detailMovieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
        
    }
    
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<DetailMovieReviewResponse, any Error> {
        let endpoint = Endpoints.Gets.movieReview(movieId: movieId)
        let url = endpoint.url
        let headers = APICall.headers
        
        return Future<DetailMovieReviewResponse, Error> { completion in
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let responseData = JSON(data)
                    let detailMovieResponse = DetailMovieReviewResponse(json: responseData)
                    completion(.success(detailMovieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovieVideos(movieId: Int) -> AnyPublisher<DetailMovieVideoResponse, any Error> {
        let endpoint = Endpoints.Gets.movieVideo(movieId: movieId)
        let url = endpoint.url
        let headers = APICall.headers
        
        return Future<DetailMovieVideoResponse, Error> {completion in
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let responseData = JSON(data)
                    let detailMovieResponse = DetailMovieVideoResponse(json: responseData)
                    completion(.success(detailMovieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
