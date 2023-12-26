//
//  ThemeColor.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 26/12/23.
//

import UIKit
protocol ThemeServiceInterface {
    func setThemeStyle(_ themeStyle: ThemeStyle)
    func getThemeStyle() -> ThemeStyle
}

final class ThemeService: ThemeServiceInterface {

    static let shared = ThemeService()

    let userDefaults: UserDefaults

    private init() {
        self.userDefaults = UserDefaults.standard
    }

    func setThemeStyle(_ themeStyle: ThemeStyle) {
        userDefaults.set(themeStyle.rawValue, forKey: PreferenceKeys.themeStyle)
    }

    func getThemeStyle() -> ThemeStyle {
        let rawValue = userDefaults.integer(forKey: PreferenceKeys.themeStyle)
        if let themeStyle = ThemeStyle(rawValue: rawValue) {
            return themeStyle
        }
        return .themeA
    }
}

struct PreferenceKeys {
    static let themeStyle = "theme_style"
}

enum ThemeStyle: Int {
    case themeA = 0
    case themeB
    case themeC
    case themeD
    case themeE
}

extension UIColor {

    static var primaryColor: UIColor {
        switch ThemeService.shared.getThemeStyle() {
        case .themeA: return .systemBlue
        case .themeB: return .systemRed
        case .themeC: return .systemGreen
        case .themeD: return .systemIndigo
        case .themeE: return .white
        }
    }

    static var secondaryColor: UIColor {
        .systemPink
    }

    // ...
}
