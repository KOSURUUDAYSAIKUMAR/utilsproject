//
//  Regex.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

enum Regex {
    static let EmailRegex: String = "[\\w._%+-|]+@[\\w0-9.-]+\\.[A-Za-z]{2,}" // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let fullName: String = "^[a-zA-Z]+$"
    static let mobileNumber: String = "^[6-9]\\d{9,10}$"
    static let numbers: String = "0123456789"
    static let validPin: String = "^\\d{6}$"
    static let emptyFields: String = "Field can\'t be empty"
}

extension UIView {
    func addBorderAndColor(color: UIColor, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth  = width
        self.layer.borderColor  = color.cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds      = clipsToBounds
    }
}

extension String {
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
