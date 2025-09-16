//
//  CustomError.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation

enum URLError: LocalizedError {
   case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .addressUnreachable(let url):
            return "Address unreachable: \(url)"
        }
    }
}

enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance:
            return "Invalid instance"
        case .requestFailed:
            return "Request failed"
        }
    }
}
