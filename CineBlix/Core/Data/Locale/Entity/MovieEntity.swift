//
//  MovieEntity.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var backdropPath: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
