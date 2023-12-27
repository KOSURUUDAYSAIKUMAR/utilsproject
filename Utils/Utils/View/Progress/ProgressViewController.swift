//
//  ProgressViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

@objc protocol ProgressDelegate: AnyObject {
    @objc optional func isProgressAnimate(status: Bool)
}

class ProgressViewController: UIViewController {

    override var preferredContentSize: CGSize {
        get {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                view.topAnchor.constraint(equalTo: view.topAnchor),
                view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:1)
                   ])
            
            return CGSize(width: view.frame.width, height: 100.0)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    @IBOutlet weak var defaultProgress: UIView!
    
    @IBOutlet weak var customIndicator1: AJProgressView!
    @IBOutlet weak var customIndicator: ProgressDialogue!
    @IBOutlet weak var progressImg: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var customProgress: UIView!
    
    var progressTag = 0
    weak var delegate : ProgressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch progressTag {
        case 0:
            progressImg.isHidden = true
            defaultProgress.alpha = 1
            customProgress.alpha = 0
        default:
            progressImg.isHidden = false
            defaultProgress.alpha = 0
            customProgress.alpha = 1
        }
        start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            stop()
        }
    }
    
    func start() {
        delegate?.isProgressAnimate?(status: true)
        switch progressTag {
        case 0:
            activityIndicator.startAnimating()
        default:
//            customIndicator1.firstColor = .green
//            customIndicator1.duration = 3.0
//            customIndicator1.lineWidth = 4.0
//            customIndicator1.bgColor =  UIColor.clear
//            customIndicator1.show()
            customIndicator.spinnerLineWidth = 3
            customIndicator.spinnerDuration = 0.3
            customIndicator.spinnerStrokeColor = UIColor.green.cgColor
        }
    }
    
    func stop() {
        delegate?.isProgressAnimate?(status: false)
        switch progressTag {
        case 0:
            activityIndicator.stopAnimating()
        case 1:
//            customIndicator1.hide()
            customIndicator.animateStop()
        default:
            return
        }
        dismiss(animated: true, completion: nil)
    }
}
