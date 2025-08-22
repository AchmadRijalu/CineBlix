//
//  DetailMovieRouter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 01/10/24.
//

import Foundation
import SwiftUI
import UIKit

class DetailMovieRouter {
    
    func presentGeneralError(errorMessage: String) {
         let bottomSheetTransitionDelegate = BottomSheetTransitionDelegate()
        let sheetVC = APIErrorBottomSheet(image: UIImage(systemName: "exclamationmark.triangle"), title: "Ooopss.", message: errorMessage)
        
        sheetVC.modalPresentationStyle = .custom
        sheetVC.transitioningDelegate = bottomSheetTransitionDelegate
        
        if let topVC = UIApplication.shared.topViewController() {
            topVC.present(sheetVC, animated: true)
        }
    }
}

