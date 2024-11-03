//
//  ProfileNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultProfileNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentAttandenceView(isFromHomeScreen: Bool?) -> some View {
        AttendanceView(viewModel: DefaultAttendanceViewModel(), isFromHomeScreen: isFromHomeScreen)
    }
    
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
    
    func presentLeaveView(isFromHomeScreen: Bool?) -> some View {
        LeavesView(viewModel: DefaultLeaveViewModel(), isFromHomeScreen: isFromHomeScreen)
    }
    
    @ViewBuilder
    func presentTripView() -> some View {
        TripRequestView(viewModel: DefaultTripRequestViewModel())
    }
}
