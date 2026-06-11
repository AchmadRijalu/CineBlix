//
//  SearchPresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 10/08/25.
//

import SwiftUI
import Combine
import Search

class SearchPresenter: ObservableObject {
    
    private let searchMovieRouter = SearchRouter()
    private let searchMovieUseCase: SearchMovieUserCase
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var searchMovieList: [SearchMovieModel] = []
    @Published var queryMovie: String = ""
    @Published var searchLoadingState: Bool = false
    
    init(searchMovieUseCase: SearchMovieUserCase) {
        self.searchMovieUseCase = searchMovieUseCase
        self.fetchMovies()
    }
    
    func fetchSearchMovie(query: String, page: Int) {
        searchMovieList.removeAll()
        searchLoadingState = true
        
        searchMovieUseCase.fetchSearchMovie(query: query, page: page).receive(on: RunLoop.main).sink { completion in
            switch completion {
            case .finished:
                self.searchLoadingState = false
            case .failure(let error):
                self.searchLoadingState = false
                let errorMessage = String(describing: error)
                self.presentGeneralError(errorMessage: errorMessage)
            }
        } receiveValue: { searchMovieResult in
            self.searchMovieList = searchMovieResult
        }.store(in: &cancellables)
        
    }
    
    func presentGeneralError(errorMessage: String) {
        ErrorBottomSheetPresenter.present(message: errorMessage)
    }

    func navigateToDetailMovie<Content: View>(movieId: Int, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: DeferredView { self.searchMovieRouter.createDetailMovie(movieId: movieId) }
        ) {
            content()
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
extension SearchPresenter {
    func fetchMovies() {
        $queryMovie.debounce(for: .milliseconds(500), scheduler: RunLoop.main).removeDuplicates().sink { [weak self]
            queryData in
            guard let self = self else { return }
            if queryData.isEmpty {
                self.searchMovieList = []
                self.searchLoadingState = false
            }
            else {
                self.fetchSearchMovie(query: queryData, page: 1)
            }
        }.store(in: &cancellables)
    }
}
