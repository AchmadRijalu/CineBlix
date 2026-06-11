//
//  CustomError+Extensions.swift
//  Core
//
//  Created by Achmad Rijalu on 21/11/25.
//

import Foundation


public enum URLError: LocalizedError {
   case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .addressUnreachable(let url):
            return "Address unreachable: \(url)"
        }
    }
}

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance:
            return "Invalid instance"
        case .requestFailed:
            return "Request failed"
        }
    }
}
