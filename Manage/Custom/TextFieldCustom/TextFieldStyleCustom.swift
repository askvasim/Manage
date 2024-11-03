//
//  TextFieldStyleCustom.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI

struct TextFieldStyleCustom: TextFieldStyle {
    let placeholder: String
    let placeholderBgColor: Color
    var errorColor: Color
    var successColor: Color
    @Binding var state: ValidInvalidState
    
    func _body(configuration: TextField<_Label>) -> some View {
        ZStack(alignment: .leading) {
            Text(LocalizedStringKey(placeholder))
                .font(.appFont(.regular, size: 14))
                .foregroundColor(setColor())
                .padding(.horizontal, (state != .normal) ? 10: 0)
                .background(placeholderBgColor) // background color of text when placed between border
                .offset(y: (state != .normal) ? -28 : 0)
                .scaleEffect((state != .normal) ? 0.8 : 1, anchor: .leading)
            
            configuration
                .font(.appFont(.regular, size: 14))
                .foregroundColor(.appPrimaryFont)
        }
        .animation(.easeOut)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(setColor())
                .frame(height: 44)
        )
    }
    
    func setColor() -> Color {
        switch state {
        case .success:
            return successColor
        case .error:
            return errorColor
        case .normal:
            return AppColor.appLightGrayFont
        }
    }
}
