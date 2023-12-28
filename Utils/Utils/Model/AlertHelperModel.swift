//
//  AlertHelperModel.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

@objc protocol BaseVCProtocol {
    @objc optional func showAlert(msg: String)
}

class AlertHelperModel: NSObject {
   
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertWithYesNo(title: String, message: String, button1: String = "Yes", noButton: String = "No", viewController: UIViewController, yesAction: @escaping () -> Void, noAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            yesAction()
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
            noAction()
        }
        alertController.addAction(noAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
