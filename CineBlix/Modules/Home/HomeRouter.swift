//
//  HomeRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 12/07/25.
//

import SwiftUI

class HomeRouter: NSObject {
    private static var isPresentingError = false
    
    func createDetailMovieView(movieId: Int) -> some View {
        let detailMovieUseCase = Injection.init().provideDetailMovie()
        let detailMoviePresenter = DetailMoviePresenter(detailMovieUseCase: detailMovieUseCase, movieId: movieId)
        return DetailMovieView(detailMoviePresenter: detailMoviePresenter).hideTabBar()
    }
    
    func createFavoriteMovieView() -> some View {
        return FavoriteView()
    }
    
    func presentGeneralError(errorMessage: String) {
            guard !HomeRouter.isPresentingError else { return }
            HomeRouter.isPresentingError = true

            let bottomSheetTransitionDelegate = BottomSheetTransitionDelegate()
            let sheetVC = APIErrorBottomSheet(
                image: UIImage(systemName: "exclamationmark.triangle"),
                title: "Error",
                message: errorMessage
            )
            sheetVC.modalPresentationStyle = .custom
            sheetVC.transitioningDelegate = bottomSheetTransitionDelegate

            sheetVC.presentationController?.delegate = self

            if let topVC = UIApplication.shared.topViewController(),
               topVC.presentedViewController == nil {
                topVC.present(sheetVC, animated: true)
            }
        }
}

extension HomeRouter: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        HomeRouter.isPresentingError = false
    }
}

