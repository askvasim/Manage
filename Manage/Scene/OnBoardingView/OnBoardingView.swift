//
//  OnBoardingView.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import SwiftUI
import Combine
import Resolver
import Domain

struct OnBoardingView<VM: OnBoardingViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject var navigator: DefaultOnBoardingNavigator
    
    @AppStorage("_shouldShowOnboarding") var shouldShowOnboarding: Bool = false
    @State var isNavigateScreen = false
    
    var body: some View {
        ZStack {
            content()
                .onAppear {
                    AppState.shared.swipeEnabled = false
                }
                .onDisappear {
                    AppState.shared.swipeEnabled = false
                }
            
            NavigationLink(destination: navigator.presentLoginView(),
                           isActive: $isNavigateScreen,
                           label: { EmptyView() })
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack(alignment: .center, spacing: 20) {
            Image("ic_splash_screen")
                .padding(.bottom, 30)
            
            Text("Everything you need to start and manage your business")
                .font(Font.custom("Roboto-Bold", size: 32))
            
            Spacer()
            
            Button(action: {
                // Action
                shouldShowOnboarding = true
                isNavigateScreen = true
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 155, height: 155, alignment: .center)
                        .foregroundColor(.appGrayBackground)
                    
                    Circle()
                        .frame(width: 90, height: 90, alignment: .center)
                        .foregroundColor(.appPrimaryColor)
                    
                    VStack(spacing: 10) {
                        Text("Start Now")
                            .font(Font.custom("Roboto-Light", size: 14))
                            .foregroundColor(.appPrimaryFont)
                        
                        Image("ic_start_now_arrow")
                            .foregroundColor(.appPrimaryFont)
                    }
                }
            })
            
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    OnBoardingView(viewModel: DefaultOnBoardingViewModel())
}
