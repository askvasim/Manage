//
//  TextFieldTypeEnum.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI

enum TextFieldTypeEnum {
    case number
    case otp
    case normal
    
    var minLength: Int? {
        switch self {
        case .number: return 10
        case .otp: return 4
        case .normal: return 3
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .number: return 10
        case .otp : return 4
        case .normal: return nil
        }
    }
    
    var bodyMessage: String? {
        switch self {
        case .number: return "Please enter a valid 10-digit mobile number"
        case .otp: return "Please enter a valid 4-digit OTP"
        case .normal: return "Field should not be blank"
        }
    }
    
    var keyboardType: UIKeyboardType? {
        switch self {
        case .number:
            return .numberPad
        case .otp:
            return .phonePad
        case .normal:
            return .default
        }
    }
    
    func validateMinMaxValues(_ val: String) -> Bool {
        guard let fieldLowerLimit = self.minLength,
              let fieldUpperLimit = self.maxLength,
              val.count >= fieldLowerLimit,
              val.count <= fieldUpperLimit else {
            return false
        }
        return true
    }
}
