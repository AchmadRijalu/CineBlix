//
//  GetHomeListRepository.swift
//  Home
//
//  Created by Achmad Rijalu on 29/05/26.
//

import Core
import Combine

public struct GetHomeListRepository<
    Locale: LocaleDataSource,
    Remote: DataSource,
    Transformer: Mapper
>: Repository
where
    Locale.Request == HomeListRequest,
    Locale.Response == HomeMovieEntity,
    Remote.Request == HomeListRequest,
    Remote.Response == MoviesResponse,
    Transformer.Response == [MoviesResultResponse],
    Transformer.Domain == [MovieResultModel],
    Transformer.Entity == [HomeMovieEntity] {

    public typealias Request = HomeListRequest
    public typealias Response = [MovieResultModel]

    private let localeDataSource: Locale
    private let remoteDataSource: Remote
    private let mapper: Transformer

    public init(
        localeDataSource: Locale,
        remoteDataSource: Remote,
        mapper: Transformer
    ) {
        self.localeDataSource = localeDataSource
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    public func execute(request: HomeListRequest?) -> AnyPublisher<[MovieResultModel], Error> {
        guard let request else {
            return Fail(error: Core.URLError.invalidResponse).eraseToAnyPublisher()
        }

        if !request.usesCache {
            return fetchFromRemote(request: request)
        }

        return localeDataSource.list(request: request).flatMap { [self] entities -> AnyPublisher<[MovieResultModel], Error> in
            if entities.isEmpty {
                return fetchFromRemoteAndCache(request: request)
            }
            return Just(mapper.transformEntityToDomain(entity: entities))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

    private func fetchFromRemote(request: HomeListRequest) -> AnyPublisher<[MovieResultModel], Error> {
        remoteDataSource.execute(request: request)
            .map { [mapper] response in
                mapper.transformResponseToDomain(response: response.results)
            }
            .eraseToAnyPublisher()
    }

    private func fetchFromRemoteAndCache(request: HomeListRequest) -> AnyPublisher<[MovieResultModel], Error> {
        remoteDataSource.execute(request: request)
            .map { [mapper] response in
                var entities = mapper.transformResponseToEntity(response: response.results)
                for index in entities.indices {
                    entities[index].listType = request.listType
                }
                return entities
            }
            .flatMap { [localeDataSource, mapper] entities in
                localeDataSource.add(entities: entities)
                    .filter { $0 }
                    .flatMap { _ in
                        localeDataSource.list(request: request)
                            .map { cached in
                                mapper.transformEntityToDomain(entity: cached)
                            }
                    }
            }
            .eraseToAnyPublisher()
    }
}
