//
//  SearchRequest.swift
//  Search
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public enum SearchRequest: Sendable {
    case search(endpointURL: String, query: String, page: Int)
}
