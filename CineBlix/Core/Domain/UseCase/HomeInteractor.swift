//
//  HomeInteractor.swift
//  CineBlix
//

import Combine
import Core
import Home

protocol HomeUseCase {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error>
}

typealias HomeMovieListRepository = GetHomeListRepository<
    GetHomeListLocaleDataSource,
    GetHomeListRemoteDataSource,
    MovieResultTransformer
>

typealias HomeMovieListInteractor = Interactor<
    HomeListRequest,
    [MovieResultModel],
    HomeMovieListRepository
>

final class HomeInteractor: HomeUseCase {

    private let listUseCase: HomeMovieListInteractor

    init(listUseCase: HomeMovieListInteractor) {
        self.listUseCase = listUseCase
    }

    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error> {
        listUseCase.execute(
            request: HomeListRequest(
                endpointURL: Endpoints.Gets.movieNowPlaying(page: page).url,
                listType: HomeListRequest.nowPlayingListType,
                usesCache: true
            )
        )
    }

    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error> {
        listUseCase.execute(
            request: HomeListRequest(
                endpointURL: Endpoints.Gets.movieTopRated(page: page).url,
                listType: "top_rated",
                usesCache: false
            )
        )
    }
}
