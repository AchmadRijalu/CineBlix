//
//  HomePresenterTest.swift
//  CineblixTest
//
//  Created by Achmad Rijalu on 08/11/25.
//

import XCTest
import Combine
@testable import CineBlix

final class HomePresenterTest: XCTestCase {
    
    var presenter: HomePresenter!
    var mockHomeUseCase: MockHomeUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockHomeUseCase = MockHomeUseCase()
        presenter = HomePresenter(homeUseCase: mockHomeUseCase)
        cancellables = []
    }
    
    override func tearDown() {
        presenter = nil
        mockHomeUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetNowPlayingMovieSuccess() {
        let expectation = XCTestExpectation(description: "Get now playing movies")
        let mockMovies = [
            MovieResultModel(
                id: 1,
                posterPath: "",
                title: "Test Movie 1",
                voteAverage: 8.0,
                addedAt: Date(),
                backdropPath: nil
            ),
            MovieResultModel(
                id: 2,
                posterPath: "",
                title: "Test Movie 2",
                voteAverage: 7.5,
                addedAt: Date(),
                backdropPath: nil
            )
        ]

        mockHomeUseCase.nowPlayingMoviesResult = .success(mockMovies)
        presenter.getNowPlayingMovie(page: 1)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.presenter.movieNowPlayingResultsModel.count, 2)
            XCTAssertEqual(self.presenter.movieNowPlayingResultsModel.first?.title, "Test Movie 1")
            XCTAssertFalse(self.presenter.nowPlayingLoadingState)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetTopRatedMovieSuccess() {
        let expectation = XCTestExpectation(description: "Get top rated movies")
        let mockMovies = [
            MovieResultModel(
                id: 1,
                posterPath: "",
                title: "Test Movie 1",
                voteAverage: 8.0,
                addedAt: Date(),
                backdropPath: nil
            ),
        ]
        

        mockHomeUseCase.topRatedMoviesResult = .success(mockMovies)
        presenter.getTopRatetdMovie(page: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.presenter.movieTopRatedResultmodel.count, 1)
            XCTAssertEqual(self.presenter.movieTopRatedResultmodel.first?.title, "Top Movie")
            XCTAssertFalse(self.presenter.topRatedLoadingState)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetNowPlayingMovieFailure() {
        let expectation = XCTestExpectation(description: "Handle error")
        mockHomeUseCase.nowPlayingMoviesResult = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        
        // When
        presenter.getNowPlayingMovie(page: 1)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.presenter.movieNowPlayingResultsModel.isEmpty)
            XCTAssertFalse(self.presenter.errorMessage.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// MARK: - Mock HomeUseCase
class MockHomeUseCase: HomeUseCase {
    var nowPlayingMoviesResult: Result<[MovieResultModel], Error> = .success([])
    var topRatedMoviesResult: Result<[MovieResultModel], Error> = .success([])
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error> {
        return nowPlayingMoviesResult.publisher
            .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResultModel], Error> {
        return topRatedMoviesResult.publisher
            .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
