//
//  Home.swift
//  Home
//
//  Created by Achmad Rijalu on 29/11/25.
//

import Core
import Combine

public struct GetHomeListRepository<GetHomeListLocaleDataSource: LocaleDataSource, GetHomeListRemoteDataSource: DataSource, Transformer: Mapper>: Repository where GetHomeListLocaleDataSource.Response == HomeMovieEntity, GetHomeListRemoteDataSource.Response == MoviesResponse, Transformer.Response == [MoviesResultResponse], Transformer.Domain == [MovieResultModel], Transformer.Entity == [HomeMovieEntity] {
    
    public typealias Request = Any
    
    public typealias Response = [MovieResultModel]
    
    private let _localeDataSource: GetHomeListLocaleDataSource
    private let _remoteDataSource: GetHomeListRemoteDataSource
    private let _mapper: Transformer
    
    public init(_localeDataSource: GetHomeListLocaleDataSource, _remoteDataSource: GetHomeListRemoteDataSource, _mapper: Transformer) {
        self._localeDataSource = _localeDataSource
        self._remoteDataSource = _remoteDataSource
        self._mapper = _mapper
    }
    
    
    public func execute(request: Request?) -> AnyPublisher<[MovieResultModel], any Error> {
        return self._localeDataSource.list(request: nil).flatMap { movieEntities -> AnyPublisher<[MovieResultModel], Error> in
            if movieEntities.isEmpty {
                return self._remoteDataSource.execute(request: nil).map { moviesResponse in
                    _mapper.transformResponseToEntity(response: moviesResponse.results)
                }.flatMap { movieEntities in
                    self._localeDataSource.add(entities: movieEntities)
                }
                .filter { $0 }
                .flatMap { _ in self._localeDataSource.list(request: nil)
                .map { movieEntities in
                    _mapper.transformEntityToDomain(entity: movieEntities)}
                }.eraseToAnyPublisher()
            }
            else {
                return self._localeDataSource.list(request: nil).map { movieEntities in
                    _mapper.transformEntityToDomain(entity: movieEntities)
                }.eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
    
}
