//
//  APICall.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation
import Alamofire

struct APICall{
    static let baseUrl = "https://api.themoviedb.org/3"
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
    
    static var headers: HTTPHeaders {
        return ["Accept": "application/json"]
    }
}

protocol Endpoint {
    var url: String {get}
}

enum Endpoints {
    enum Gets: Endpoint {
        case movieNowPlaying(page: Int)
        case movieUpcoming(page: Int)
        case moviePopular(page: Int)
        case movieInfo(movieId: Int)
        case movieVideo(movieId: Int)
        case movieReview(movieId: Int)
        case image(imageFilePath: String)
        case movieTopRated(page: Int)
        case searchMovie(query: String, page: Int)
        
        var url: String {
            switch self {
            case .movieNowPlaying(let page):
                return "\(APICall.baseUrl)/movie/now_playing?api_key=\(APICall.apiKey)&page=\(page)"
            case .movieUpcoming(page: let page):
                return "\(APICall.baseUrl)/movie/upcoming?api_key=\(APICall.apiKey)&page=\(page)"
            case .moviePopular(page: let page):
                return "\(APICall.baseUrl)/movie/popular?api_key=\(APICall.apiKey)&page=\(page)"
            case .movieInfo(let movieId):
                return "\(APICall.baseUrl)/movie/\(movieId)?api_key=\(APICall.apiKey)"
            case .image(let imageFilePath):
                return "\(APICall.baseImageUrl)/\(imageFilePath)"
            case .movieVideo(movieId: let movieId):
                return "\(APICall.baseUrl)/movie/\(movieId)/videos?api_key=\(APICall.apiKey)"
            case .movieReview(movieId: let movieId):
                return "\(APICall.baseUrl)/movie/\(movieId)/reviews?api_key=\(APICall.apiKey)"
            case .movieTopRated(let page):
                return "\(APICall.baseUrl)/movie/top_rated?api_key=\(APICall.apiKey)&page=\(page)"
            case .searchMovie(query: let query, page: let page):
                let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
                return "\(APICall.baseUrl)/search/movie?api_key=\(APICall.apiKey)&query=\(encodedQuery)&page=\(page)"
            }
        }
    }
}
