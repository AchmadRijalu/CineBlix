//
//  HomeInteractor.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 06/12/24.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    
    func getNowPlayingMovies() -> Observable<[MovieNowPlayingResultModel]>
}


class HomeInteractor: HomeUseCase {
    private let repository: MovieRepositoryProtocol
    
     init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    func getNowPlayingMovies() -> RxSwift.Observable<[MovieNowPlayingResultModel]> {
        return repository.getNowPlayingMovies()
    }
    
    
}
