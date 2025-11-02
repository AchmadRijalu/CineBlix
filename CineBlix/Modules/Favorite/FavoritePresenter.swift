//
//  FavoritePresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/10/24.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    var router = FavoriteRouter()
    var useCase: FavoriteMovieUseCase
    
    init(useCase: FavoriteMovieUseCase) {
        self.useCase = useCase
    }
    @Published var favoriteMovies: [MovieResultModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    func getAllFavoriteMovie() {
        self.isLoading = true
        useCase.fetchFavoriteMovies().receive(on: DispatchQueue.main).sink { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .finished:
                self.isLoading = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { movieDatas in
            self.favoriteMovies = movieDatas
        }.store(in: &cancellables)
    }
    
    func navigateToDetailMovie<Content: View>(movieId: Int, @ViewBuilder content: () -> Content) -> some View {
        return NavigationLink {
            router.createDetailMovieView(movieId: movieId)
        } label: {
            content()
        }
    }
    
    func deleteFavoriteMovie(movieId: Int) {
        self.useCase.deleteFavoriteMovie(movieId: movieId).receive(on: DispatchQueue.main).sink { completion in
            if case .failure(_) = completion {}
        } receiveValue: { isDeleted in
            print("Deleted Data \(isDeleted)")
        }.store(in: &cancellables)
        self.getAllFavoriteMovie()
    }
}
