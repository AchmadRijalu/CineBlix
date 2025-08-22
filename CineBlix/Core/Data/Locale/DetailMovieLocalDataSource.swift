//
//  DetailMovieLocalDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 17/07/25.
//

import RealmSwift
import Foundation

protocol DetailMovieLocalDataSourceProcol {}

class DetailMovieLocalDataSource: NSObject {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    static let shared: (Realm) -> DetailMovieLocalDataSource = { realm in
        return DetailMovieLocalDataSource(realm: realm)
    }
}

extension DetailMovieLocalDataSource: DetailMovieLocalDataSourceProcol {
    
}
