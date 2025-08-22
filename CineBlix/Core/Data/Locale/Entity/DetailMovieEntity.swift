//
//  DetailMovieEntity.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 17/07/25.
//

import Foundation
import RealmSwift

class DetaiMovieEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var reviewerName: String = ""
    @objc dynamic var reviewerRating: Double = 0
    @objc dynamic var reviewerContent: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
