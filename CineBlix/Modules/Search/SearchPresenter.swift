//
//  SearchPresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 10/08/25.
//

import SwiftUI
import Combine

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
                let errorMessage = String(describing: error)
                self.presentGeneralError(errorMessage: errorMessage)
            }
        } receiveValue: { searchMovieResult in
            self.searchMovieList = searchMovieResult
        }.store(in: &cancellables)
        
    }
    
    func presentGeneralError(errorMessage: String) {
        let bottomSheetTransitionDelegate = BottomSheetTransitionDelegate()
        let sheetVC = APIErrorBottomSheet(image: UIImage(systemName: "exclamationmark.triangle"), title: "Ooopss.", message: errorMessage)
        
        sheetVC.modalPresentationStyle = .custom
        sheetVC.transitioningDelegate = bottomSheetTransitionDelegate
        
        if let topVC = UIApplication.shared.topViewController() {
            topVC.present(sheetVC, animated: true)
        }
    }
    
    func navigateToDetailMovie<Content: View>(movieId: Int, @ViewBuilder content: () -> Content ) -> some View {
        NavigationLink {
            searchMovieRouter.createDetailMovie(movieId: movieId)
        } label: {
            content()
        }

    }
}
extension SearchPresenter {
    func fetchMovies() {
        $queryMovie.debounce(for: .milliseconds(500), scheduler: RunLoop.main).removeDuplicates().sink { [weak self]
            queryData in
            guard let self = self else { return }
            if queryData.isEmpty {
                self.searchMovieList = []
            }
            else {
                self.fetchSearchMovie(query: queryData, page: 1)
            }
        }.store(in: &cancellables)
    }
}
