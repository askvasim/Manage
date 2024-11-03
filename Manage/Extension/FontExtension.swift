//
//  FontExtension.swift
//  Manage
//
//  Created by Vasim Khan on 10/20/24.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public extension UIFont {
    enum CashWiseFonts {
        case light
        case regular
        case medium
        case bold
        case custom(String)
        
        var value: String {
            var inter = "Roboto-"
            
            if let currentLang = (UserDefaults.standard.value(forKey: "AppleLanguages") as? NSArray)?.firstObject as? String {
                if currentLang == "hi" {
                    inter = "Mukta-"
                } else {
                    inter = "Roboto-"
                }
            }
            
            switch self {
            case .light:
                return inter + "Light"
            case .regular:
                return inter + "Regular"
            case .medium:
                return inter + "Medium"
            case .bold:
                return inter + "Bold"
            case let .custom(name):
                return name
            }
        }
    }

    static func appFont(_ type: CashWiseFonts, size: CGFloat = 14) -> UIFont {
        return UIFont(name: type.value, size: size)!
//        return .custom(type.value, size: size)
    }
}

@available(iOS 14.0, *)
public extension View {
    func font(_ font: UIFont, lineHeight: CGFloat? = 0) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: (lineHeight == 0 ? font.lineHeight : lineHeight) ?? font.lineHeight))
    }
}

struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat
    
    @available(iOS 13.0.0, *)
    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

