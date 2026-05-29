//
//  HomeMovieEntity.swift
//  Home
//
//  Created by Achmad Rijalu on 23/11/25.
//

import Foundation
import RealmSwift

public class HomeMovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var listType: String = ""

    public override class func primaryKey() -> String? {
        return "id"
    }
}
