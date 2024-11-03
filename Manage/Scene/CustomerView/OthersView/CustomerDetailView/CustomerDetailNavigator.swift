//
//  CustomerDetailNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultCustomerDetailNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentEditCustomerView(leadData: LeadList) -> some View {
        EditCustomerView(viewModel: DefaultEditCustomerViewModel(), leadData: leadData)
    }
}
