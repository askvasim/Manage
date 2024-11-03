//
//  SplashNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/22/24.
//

import SwiftUI
import Data
import Resolver

public final class DefaultSplashNavigator: ObservableObject {
    @ObservedObject var appState = AppState()
    
    init() {}
    
    @ViewBuilder
    func navigateToOtherScreen() -> some View {
        OnBoardingView(viewModel: DefaultOnBoardingViewModel())
            .id(appState.rootViewId)
    }
}
