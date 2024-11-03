//
//  LogInScreen.swift
//  Manage
//
//  Created by Vasim Khan on 10/22/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct LogInScreen<VM: LogInViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultLogInNavigator
    
    @State var currentScreen: AuthenticationScreenState = .enterNumber
    @ObservedObject var mobileValidator = TextValidator()
    @ObservedObject var otpValidator = TextValidator()
    
    @State var mobileFieldState: ValidInvalidState = .normal
    @State var otpFieldState: ValidInvalidState = .normal
    
    @State var isDashboardViewPresented: Bool = false
    
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var cancellable: Cancellable? = nil
    @State private var remainingTime = 6
    
    @State var thisText: String = ""
    
    var body: some View {
        ZStack {
            content()
                .onAppear {
                    AppState.shared.swipeEnabled = false
                }
                .onDisappear {
                    AppState.shared.swipeEnabled = false
                }
            
            NavigationLink(destination: navigator.presentDashboardView(),
                           isActive: $isDashboardViewPresented,
                           label: { EmptyView() })
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            VStack {
                Image("ic_app_name")
                    .padding(.bottom, 72)
                
                    VStack(alignment: .leading, spacing: 10) {
                        TextFieldViewCustom(
                            placeholder: currentScreen == .enterNumber ? "Enter Mobile Number" : "Enter OTP",
                            textFieldType: currentScreen == .enterNumber ? .number : .otp,
                            item: currentScreen == .enterNumber ? mobileValidator: otpValidator,
                            fieldState: currentScreen == .enterNumber ? $mobileFieldState : $otpFieldState
                        )
                    }
                    .padding(.horizontal, 25)
                    
                    Text("Enter your registered mobile number to \nproceed to the next screen.")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Roboto-Regular", size: 14))
            }
            .padding(.top, 150)
            
            Spacer()
            
            Button(currentScreen == .enterNumber ? "REQUEST OTP" : "NEXT") {
                
                switch currentScreen {
                case .enterNumber:
                    if mobileValidator.text == "9876543210" {
                        currentScreen = .enterOtp
                        self.startTimer()
                    }
                    print(mobileValidator.text)
                    
                case .enterOtp:
                    if otpValidator.text == "1234" {
                        isDashboardViewPresented = true
                    }
                    print(otpValidator.text)
                }
            }
            .disabled(currentScreen == .enterNumber ? !(mobileFieldState == .success) : !(otpFieldState == .success))
            .buttonStyle(
                PrimaryButtonStyleCustom(
                    disabled: currentScreen == .enterNumber ? !(mobileFieldState == .success) : !(otpFieldState == .success)
                )
            )
            .padding(.horizontal, 25)
        }
        .padding(.bottom, 25)
    }
    
    func startTimer() {
        self.remainingTime = 6
        self.timer = Timer.publish(every: 1.1, on: .main, in: .common)
        self.cancellable = self.timer.connect()
        return
    }
    
    func stopTimer() {
        self.cancellable?.cancel()
        return
    }
    
    func restartTimer() {
        self.remainingTime = 6
        self.stopTimer()
        self.startTimer()
        return
    }
}

#Preview {
    LogInScreen(viewModel: DefaultLogInViewModel())
}
