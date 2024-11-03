//
//  ColorExtension.swift
//  Manage
//
//  Created by Vasim Khan on 10/20/24.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public typealias AppColor = Color //typealias to distinguish between system and app colors

@available(iOS 14.0, *)
public extension Color {
    // Primary Color
    static let appPrimaryColor = Color("app_primary_color")
    
    // Font Color
    static let appPrimaryFontColor = Color("app_primary_font")
    static let appGrayFontColor = Color("app_gray_font")
    static let appLightGrayFontColor = Color("app_light_gray_font")
    static let appWhiteFontColor = Color("app_white_font")
    static let appBlackFontColor = Color("app_black_font")
    
    // Color Integrators
    static let appLightBlueColor = Color("app_light_blue")
    static let appLightPurpleColor = Color("app_light_purple")
    static let appLightGreenColor = Color("app_light_green")
    static let appLightYellowColor = Color("app_light_yellow")
    static let appLightRedColor = Color("app_light_red")
    
    // Background & Strokes
    static let appGrayBackgroundColor = Color("app_gray_background")
    static let appLightGrayBackgroundColor = Color("app_light_gray_background")
    static let appGrayStrokeColor = Color("app_gray_stroke")
    static let appTextBoxStrokeColor = Color("app_text_box_stroke")
}
