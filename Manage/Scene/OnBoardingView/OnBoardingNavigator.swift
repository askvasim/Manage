//
//  OnBoardingNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import Resolver
import SwiftUI
import Data

public final class DefaultOnBoardingNavigator: ObservableObject {
    
    init() {}
    
    func presentLoginView() -> some View {
        return LogInScreen(viewModel: DefaultLogInViewModel())
    }
}
