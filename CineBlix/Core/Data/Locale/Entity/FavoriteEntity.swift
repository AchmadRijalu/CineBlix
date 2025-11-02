//
//  FavoriteEntity.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 04/10/25.
//

import RealmSwift
import Foundation

class FavoriteEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var addedAt: Date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
