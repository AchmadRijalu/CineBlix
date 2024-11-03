//
//  APICall.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation

struct APICall{
    
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}

protocol Endpoint {
    var url: String {get}
}

enum Endpoints {
    enum Gets: Endpoint {
        case moveList
        case movieDetail
        
        public var url: String {
            switch self {
            case .moveList: return ""
            case .movieDetail: return ""
                
            }
        }
    }
}
