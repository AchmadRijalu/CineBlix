//
//  HomeRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/07/25.
//

import SwiftUI

class HomeRouter {
    func createDetailMovieView(movieId: Int) -> some View {
        let detailMovieUseCase = Injection.init().provideDetailMovie()
        let detailMoviePresenter = DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: movieId)
        return DetailMovieView(detailMoviePresenter: detailMoviePresenter)
    }
    
    func createFavoriteMovieView() -> some View {
        return FavoriteView()
    }
    
    func presentGeneralError(errorMessage: String) {
         let bottomSheetTransitionDelegate = BottomSheetTransitionDelegate()
        
        let sheetVC = APIErrorBottomSheet(image: UIImage(systemName: "exclamationmark.triangle"), title: "Error", message: errorMessage)
        
        sheetVC.modalPresentationStyle = .custom
        sheetVC.transitioningDelegate = bottomSheetTransitionDelegate
        
        if let topVC = UIApplication.shared.topViewController() {
            topVC.present(sheetVC, animated: true)
        }
    }
}

