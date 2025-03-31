//
//  Injection.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation
import RealmSwift


final class Injection: NSObject {
    private func provideRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MovieRepository.sharedInstance(locale, remote)
    }
    
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
}
