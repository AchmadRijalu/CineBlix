//
//  FavoriteEntity.swift
//  Favorite
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Foundation
import RealmSwift

public class FavoriteEntity: Object {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var title: String = ""
    @objc public dynamic var posterPath: String = ""
    @objc public dynamic var voteAverage: Double = 0
    @objc public dynamic var addedAt: Date = Date()
    @objc public dynamic var backdropPath: String = ""

    public override class func primaryKey() -> String? {
        "id"
    }
}
