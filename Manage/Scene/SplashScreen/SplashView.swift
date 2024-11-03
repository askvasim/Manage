//
//  SplashView.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import SwiftUI
import Combine
import Resolver

struct SplashView<VM: SplashViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject var navigator: DefaultSplashNavigator
    @ObservedObject var appState = AppState()
    
    @State var isNavigateScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                content()
                
                NavigationLink(destination: navigator.navigateToOtherScreen(),
                               isActive: $isNavigateScreen,
                               label: { EmptyView() })
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isNavigateScreen = true
                }
            }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack(alignment: .center, spacing: 10) {
            Image("ic_app_name")
                .foregroundColor(AppColor.appPrimaryFont)
            
            Text("By")
                .font(Font.custom("Roboto-Light", size: 14))
                .foregroundColor(.appPrimaryFont)
                .padding(.bottom, 10)
            
            Image("ic_meril")
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    SplashView(viewModel: DefaultSplashViewModel())
}
