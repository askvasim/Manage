//
//  TextFieldViewCustom.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI
import Combine

struct TextFieldViewCustom: View {
    var placeholder: String?
    var textFieldType: TextFieldTypeEnum
    @ObservedObject var item: TextValidator
    @ObservedObject var checker = TextFieldChecker<String>()
    @Binding var fieldState: ValidInvalidState
    var onCommit: (_ isValid: Bool) -> Void = { _ in }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("", text: $item.text.onValidate(checker: checker, debounceInMills: 2000, validator: { _ in
                
                guard item.text != "" || !(item.text.isEmpty) else {
                    fieldState = .normal
                    return setCallAndReturnMessage(fieldState)
                }
                
                switch textFieldType {
                case .number:
                  
                    guard ValidationUtil.isMobileNumberValid(item.text) else {
                        fieldState = .error
                        return setCallAndReturnMessage(fieldState)
                    }
                    
                    fieldState = .success
                    return setCallAndReturnMessage(fieldState)
                    
                case .otp:
                    
                    if textFieldType.validateMinMaxValues(item.text) {
                        fieldState = .success
                        return setCallAndReturnMessage(fieldState)
                    } else {
                        fieldState = .error
                        return setCallAndReturnMessage(fieldState)
                    }
                    
                    
                case .normal:
                    fieldState = .success
                    return setCallAndReturnMessage(fieldState)
                }
            }), onEditingChanged: { isFirst in
                if isFirst {
                    fieldState = .normal
                }
            })
            
            .keyboardType(textFieldType.keyboardType ?? .default)
            .textFieldStyle(
                TextFieldStyleCustom(
                    placeholder: placeholder ?? "",
                    placeholderBgColor: .appPrimary,
                    errorColor: AppColor.red,
                    successColor: AppColor.appPrimaryFont,
                    state: $fieldState)
            )
            .onReceive(Just(item.text)) { (newValue) in
                let textUpperLimit = textFieldType.maxLength ?? 30
                
                if item.text.count > textUpperLimit {
                    item.text = "\(item.text.prefix(textUpperLimit))"
                }
            }
            
            Text(fieldState == .error ? checker.errorMessage ?? "" : "")
                .multilineTextAlignment(.leading)
                .font(.appFont(.medium, size: 12))
                .foregroundColor(AppColor.red)
        }
    }
    
    func setCallAndReturnMessage(_ state: ValidInvalidState) -> String? {
        switch state {
        case .success:
            self.onCommit(true)
            return nil
        case .error:
            self.onCommit(false)
            return textFieldType.bodyMessage
        case .normal:
            self.onCommit(false)
            return nil
        }
    }
}
