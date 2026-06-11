//
//  ErrorBottomSheetPresenter.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 29/05/26.
//

import UIKit

enum ErrorBottomSheetPresenter {
    private static var isPresenting = false
    private static var dismissDelegate: ErrorSheetDismissDelegate?

    static func present(title: String = "Ooopss.", message: String) {
        guard !isPresenting else { return }
        guard let topVC = UIApplication.shared.topViewController(),
              topVC.presentedViewController == nil else { return }

        isPresenting = true

        let bottomSheetTransitionDelegate = BottomSheetTransitionDelegate()
        let sheetVC = APIErrorBottomSheet(
            image: UIImage(systemName: "exclamationmark.triangle"),
            title: title,
            message: message
        )
        sheetVC.modalPresentationStyle = .custom
        sheetVC.transitioningDelegate = bottomSheetTransitionDelegate
        sheetVC.onDismiss = markDismissed

        let delegate = ErrorSheetDismissDelegate()
        dismissDelegate = delegate
        sheetVC.presentationController?.delegate = delegate

        topVC.present(sheetVC, animated: true)
    }

    static func markDismissed() {
        isPresenting = false
        dismissDelegate = nil
    }
}

private final class ErrorSheetDismissDelegate: NSObject, UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        ErrorBottomSheetPresenter.markDismissed()
    }
}
