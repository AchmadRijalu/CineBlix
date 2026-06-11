//
//  DetailMovieResult.swift
//  DetailMovie
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation

public enum DetailMovieResult: Sendable {
    case info(DetailMovieModel)
    case reviews([DetailMovieReviewModel])
    case videos([DetailMovieVideoModel])
    case favorite(Bool)
}
