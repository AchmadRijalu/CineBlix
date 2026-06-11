//
//  DetailMovieRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import SwiftUI

class DetailMovieRouter {
    
    func presentGeneralError(errorMessage: String) {
        ErrorBottomSheetPresenter.present(message: errorMessage)
    }
}
