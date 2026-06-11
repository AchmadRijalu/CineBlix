//
//  DetailMovieRemoteResponse.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public enum DetailMovieRemoteResponse: Sendable {
    case info(DetailMovieResponse)
    case reviews(DetailMovieReviewResponse)
    case videos(DetailMovieVideoResponse)
}
