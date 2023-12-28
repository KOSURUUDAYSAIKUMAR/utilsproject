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
    
    func corner(radius: CGFloat = 25) {
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
    }
}

extension String {
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UINavigationController {
  func configureTabBar(title: String, systemImageName: String) {
    let tabBarItemImage = UIImage(systemName: systemImageName)
    tabBarItem = UITabBarItem(title: title,
                              image: tabBarItemImage?.withRenderingMode(.alwaysTemplate),
                              selectedImage: tabBarItemImage)
  }

  enum titleType: CaseIterable {
    case regular, large
  }

  func setTitleColor(_ color: UIColor, _ types: [titleType] = titleType.allCases) {
    if types.contains(.regular) {
      navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    if types.contains(.large) {
      navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
    }
  }
}
