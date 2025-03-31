//
//  MovieEntity.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//


import Foundation
import RealmSwift

class MovieNowPlayingEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var voteAverage: Double = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
}
