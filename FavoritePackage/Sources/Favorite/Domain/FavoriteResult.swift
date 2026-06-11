//
//  FavoriteResult.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core
import Foundation

public enum FavoriteResult: Sendable {
    case movies([MovieResultModel])
    case deleted(Bool)
}
