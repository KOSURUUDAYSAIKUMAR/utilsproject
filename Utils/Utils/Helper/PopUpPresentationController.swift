//
//  PopUpPresentationController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

class PopUpPresentationController: UIPresentationController {
    private var backgroundView: UIView!
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView, let presentedView = presentedView else {
            return CGRect.zero
        }
        // Calculate the size based on the content of CustomAlertViewController
        let preferredContentSize = presentedViewController.preferredContentSize
        let width = preferredContentSize.width
        let height = preferredContentSize.height
        let x = (containerView.bounds.width - width) / 2.0
        let y = (containerView.bounds.height - height) / 2.0
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        setupBackgroundView()
    }
    
    override func dismissalTransitionWillBegin() {
        backgroundView.removeFromSuperview()
    }
    
    private func setupBackgroundView() {
        backgroundView = UIView(frame: containerView?.bounds ?? CGRect.zero)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Adjust opacity here
        backgroundView.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        containerView?.insertSubview(backgroundView, at: 0)
        backgroundView.isUserInteractionEnabled = true
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.backgroundView.alpha = 1.0
        }, completion: nil)
    }
    
    @objc private func backgroundViewTapped() {
       // presentedViewController.dismiss(animated: true, completion: nil)
    }
}
