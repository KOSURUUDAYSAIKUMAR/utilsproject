//
//  UIFont+CustomFont.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 28/12/23.
//

import UIKit

//class UIFont_CustomFont: NSObject { }

protocol DynamicFonts {
    func fontName() -> String
    func fontSize(style: UIFont.TextStyle) -> CGFloat
}

extension UIFont {

    class func customFont(
        _ font: DynamicFonts,
        forTextStyle style: UIFont.TextStyle,
        overrideFontSize: UIContentSizeCategory? = nil
    ) -> UIFont? {
        guard let customFont = UIFont(name: font.fontName(), size: font.fontSize(style: style)) else { return nil }
        let scaledFont: UIFont
        let metrics = UIFontMetrics(forTextStyle: style)
        scaledFont = metrics.scaledFont(
            for: customFont, compatibleWith: UITraitCollection(
                preferredContentSizeCategory: overrideFontSize ?? .unspecified
            )
        )
        return scaledFont
    }
}

enum Roboto: DynamicFonts {
    case regular
    case bold
    case medium
    case light
    case italic
    static let fontSizeTable: [UIFont.TextStyle: [UIContentSizeCategory: CGFloat]] = [
        .headline: [
            .accessibilityExtraExtraExtraLarge: 23,
            .accessibilityExtraExtraLarge: 23,
            .accessibilityExtraLarge: 23,
            .accessibilityLarge: 23,
            .accessibilityMedium: 23,
            .extraExtraExtraLarge: 23,
            .extraExtraLarge: 21,
            .extraLarge: 19,
            .large: 17,
            .medium: 16,
            .small: 15,
            .extraSmall: 14
        ],
        .subheadline: [
            .accessibilityExtraExtraExtraLarge: 21,
            .accessibilityExtraExtraLarge: 21,
            .accessibilityExtraLarge: 21,
            .accessibilityLarge: 21,
            .accessibilityMedium: 21,
            .extraExtraExtraLarge: 21,
            .extraExtraLarge: 19,
            .extraLarge: 17,
            .large: 15,
            .medium: 14,
            .small: 13,
            .extraSmall: 12
        ],
        .body: [
            .accessibilityExtraExtraExtraLarge: 53,
            .accessibilityExtraExtraLarge: 47,
            .accessibilityExtraLarge: 40,
            .accessibilityLarge: 33,
            .accessibilityMedium: 28,
            .extraExtraExtraLarge: 23,
            .extraExtraLarge: 21,
            .extraLarge: 19,
            .large: 17,
            .medium: 16,
            .small: 15,
            .extraSmall: 14
        ],
        .caption1: [
            .accessibilityExtraExtraExtraLarge: 18,
            .accessibilityExtraExtraLarge: 18,
            .accessibilityExtraLarge: 18,
            .accessibilityLarge: 18,
            .accessibilityMedium: 18,
            .extraExtraExtraLarge: 18,
            .extraExtraLarge: 16,
            .extraLarge: 14,
            .large: 12,
            .medium: 11,
            .small: 11,
            .extraSmall: 11
        ],
        .caption2: [
            .accessibilityExtraExtraExtraLarge: 17,
            .accessibilityExtraExtraLarge: 17,
            .accessibilityExtraLarge: 17,
            .accessibilityLarge: 17,
            .accessibilityMedium: 17,
            .extraExtraExtraLarge: 17,
            .extraExtraLarge: 15,
            .extraLarge: 13,
            .large: 11,
            .medium: 11,
            .small: 11,
            .extraSmall: 11
        ],
        .footnote: [
            .accessibilityExtraExtraExtraLarge: 19,
            .accessibilityExtraExtraLarge: 19,
            .accessibilityExtraLarge: 19,
            .accessibilityLarge: 19,
            .accessibilityMedium: 19,
            .extraExtraExtraLarge: 19,
            .extraExtraLarge: 17,
            .extraLarge: 15,
            .large: 13,
            .medium: 12,
            .small: 12,
            .extraSmall: 12
        ]
    ]

    func fontName() -> String {
        switch self {
        case .regular: return "Roboto-Regular"
        case .bold: return "Roboto-Bold"
        case .medium: return "Roboto-Medium"
        case .light: return "Roboto-Light"
        case .italic: return "Roboto-MediumItalic"
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func fontSize(style: UIFont.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return 34.0
        case .title1: return 28.0
        case .title2: return 22.0
        case .title3: return 20.0
        case .headline: return 18.0
        case .body: return 17.0
        case .callout: return 16.0
        case .subheadline: return 15.0
        case .footnote: return 13.0
        case .caption1: return 12.0
        case .caption2: return 11.0
        default: return 17.0
        }
    }

    func font(for style: UIFont.TextStyle, sizeCategory: UIContentSizeCategory) -> UIFont? {
        guard let style = Roboto.fontSizeTable[style],
              let size = style[sizeCategory]
        else { return nil }
        return UIFont(name: fontName(), size: size)
    }
}
