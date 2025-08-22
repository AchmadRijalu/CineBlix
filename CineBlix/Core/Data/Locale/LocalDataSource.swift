//
//  LocalDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//


import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol {
}


class LocaleDataSource: NSObject {
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmInstance in
        return LocaleDataSource(realm: realmInstance)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
}
