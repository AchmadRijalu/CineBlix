//
//  DetailMovieRequest.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core
import Foundation

public enum DetailMovieRequest: Sendable {
    case info(endpointURL: String)
    case reviews(endpointURL: String)
    case videos(endpointURL: String)
    case addFavorite(MovieResultModel)
    case removeFavorite(MovieResultModel)
    case isFavoriteExist(movieId: Int)
}
