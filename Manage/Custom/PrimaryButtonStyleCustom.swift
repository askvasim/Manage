//
//  PrimaryButtonStyleCustom.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI

struct PrimaryButtonStyleCustom: ButtonStyle {
    var disabled: Bool = false
    var image: String = ""
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if image != "" {
                Image(image)
                    .resizable()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 13.33)
            }
            configuration.label
        }
        .font(.appFont(.bold, size: 14))
        .foregroundColor(AppColor.appPrimary)
        .frame(height: 48)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(
            
            LinearGradient(
                gradient: Gradient(
                    colors: [disabled ? AppColor.appLightGrayFont : AppColor.appPrimaryFont, disabled ? AppColor.appLightGrayFont : AppColor.appPrimaryFont]
                ),
                startPoint: .top,
                endPoint: .bottom)
        )
        .cornerRadius(10)
        .scaleEffect(disabled ? 1 : configuration.isPressed ? 0.95 : 1)
    }
}

struct PrimaryButtonStyleCustom_Previews: PreviewProvider {
    static var previews: some View {
        Button("Button") {
            
        }
        .buttonStyle(PrimaryButtonStyleCustom(image: "ic_locked"))
    }
}
