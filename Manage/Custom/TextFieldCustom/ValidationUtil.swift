//
//  ValidationUtil.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI

public class ValidationUtil {
    static func isMobileNumberValid(_ num: String) -> Bool {
        let mobileRegEx = "^[0-9]*$"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
        if num.count < 10 {
            return false
        }
        return mobileTest.evaluate(with: num)
    }
}
