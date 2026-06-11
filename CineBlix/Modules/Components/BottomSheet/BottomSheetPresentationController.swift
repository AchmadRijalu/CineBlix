//
//  BottomSheetPresentationController.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 19/08/25.
//

import UIKit

class BottomSheetPresentationController: UIPresentationController {

    var dimmingView = UIView()
    private var resolvedHeight: CGFloat?

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmingView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(diTapDismiss))
        dimmingView.addGestureRecognizer(tapGesture)
    }

    @objc func diTapDismiss() {
        presentedViewController.dismiss(animated: true)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        let maximumHeight = containerView.bounds.height - 100
        let height = min(resolvedSheetHeight(), maximumHeight)

        return CGRect(
            x: 0,
            y: containerView.bounds.height - height,
            width: containerView.bounds.width,
            height: height
        )
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.insertSubview(dimmingView, at: 0)

        presentedViewController.transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = 1
        }
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = 0
        }
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    private func resolvedSheetHeight() -> CGFloat {
        if let resolvedHeight {
            return resolvedHeight
        }

        let preferredHeight = presentedViewController.preferredContentSize.height
        let height = preferredHeight > 0 ? preferredHeight : 240
        let clamped = max(height, 180)
        resolvedHeight = clamped
        return clamped
    }
}

class BottomSheetTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
