//
//  HomeNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultHomeNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentLeadGenView() -> some View {
        LeadGenerationView(viewModel: DefaultLeadGenerationViewModel())
    }
    
    @ViewBuilder
    func presentCustomerConView() -> some View {
        CustomerView(viewModel: DefaultCustomerViewModel())
    }
    
    @ViewBuilder
    func presentExpenseView() -> some View {
        ExpensesView(viewModel: DefaultExpensesViewModel())
    }
    
    @ViewBuilder
    func presentLeaveView(isFromHomeScreen: Bool?) -> some View {
        LeavesView(viewModel: DefaultLeaveViewModel(), isFromHomeScreen: isFromHomeScreen)
    }
    
    @ViewBuilder
    func presentAttandenceView(isFromHomeScreen: Bool?) -> some View {
        AttendanceView(viewModel: DefaultAttendanceViewModel(), isFromHomeScreen: isFromHomeScreen)
    }
}
