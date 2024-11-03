//
//  LeaveNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultLeaveNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentRequestLeaveView() -> some View {
        RequestLeaveView(viewModel: DefaultRequestLeaveViewModel())
    }
    
    @ViewBuilder
    func presentDetailsView(leaveData: LeavesList?, index: Int?) -> some View {
        DetailsView(viewModel: DefaultDetailsViewModel(), leaveData: leaveData, indexValue: index)
    }
}
