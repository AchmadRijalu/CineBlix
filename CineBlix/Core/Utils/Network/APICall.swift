//
//  APICall.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation

struct APICall{
    
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}

protocol Endpoint {
    var url: String {get}
}

enum Endpoints {
    enum Gets: Endpoint {
        case movieNowPlaying
        case moviePopular
        case movieDetail
        
        public var url: String {
            switch self {
            case .moviePopular: return "\(APICall.baseUrl)/popular"
            case .movieDetail: return ""
            case .movieNowPlaying: return "\(APICall.baseUrl)/now_playing?api_key=\(APICall.apiKey)"
                
            }
        }
    }
}
