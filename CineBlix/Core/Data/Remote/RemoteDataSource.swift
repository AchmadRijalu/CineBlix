//
//  RemoteDataSource.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/12/24.
//


import Foundation
import RxSwift
import Alamofire


protocol RemoteDataSourceProtocol {
//    func getPopularMovies() -> Observable<MoviePopularListModel>
    func getNowPlayingMovies() -> Observable<[MovieNowPlayingResultResponse]>
    func getPopularMovies() -> Observable<[MoviePopularResultModel]>
}

class RemoteDataSource: NSObject {
    
    override init() {
        
    }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}


extension RemoteDataSource: RemoteDataSourceProtocol {
    func getPopularMovies() -> RxSwift.Observable<[MoviePopularResultModel]> {
        
    }
    
    func getNowPlayingMovies() -> RxSwift.Observable<[MovieNowPlayingResultResponse]> {
        return Observable<[MovieNowPlayingResultResponse]>.create { observer in
            if let url = URL(string: Endpoints.Gets.movieNowPlaying.url) {
                AF.request(url).validate().responseDecodable(of: MovieNowPlayingResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.results ?? [])
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    
    
}
