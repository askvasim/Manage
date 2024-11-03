//
//  ToastViewCustom.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI

struct ToastViewCustom: View {
    @State var toastState: ValidInvalidState = .normal
    @State var headerString: String
    @State var bodyString: String
   
    var body: some View {
        
            HStack(spacing: 12) {
                Image((toastState == .success) ? "ic_success_toast" : "ic_error_toast")
                    .resizable()
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(headerString)
                        .font(.appFont(.bold,size: 16))
                    Text(bodyString)
                        .font(.appFont(.regular,size: 14))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background((toastState == .success) ? AppColor.green : AppColor.red)
            .foregroundColor(Color.white)
            .cornerRadius(5)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
    }
}

enum ValidInvalidState {
    case success
    case error
    case normal
}

enum AuthenticationScreenState {
    case enterNumber
    case enterOtp
}
