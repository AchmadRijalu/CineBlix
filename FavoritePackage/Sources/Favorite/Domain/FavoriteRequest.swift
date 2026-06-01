//
//  FavoriteRequest.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public enum FavoriteRequest: Sendable {
    case list
    case delete(movieId: Int)
}
