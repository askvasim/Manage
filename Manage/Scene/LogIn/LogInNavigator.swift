//
//  LogInNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultLogInNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentDashboardView() -> some View {
        DashboardView(viewModel: DefaultDashboardViewModel())
    }
}
