//
//  Image+Extension.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

class Image_Extension: NSObject {

}
extension UIImageView {
    func addBlackGradientLayer(frame: CGRect){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0.0, 0.5]
        layer.insertSublayer(gradient, at: 0)
    }
}
