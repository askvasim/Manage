//
//  CustomerNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultCustomerNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentCustomerDetailView(leadData: LeadList?) -> some View {
        CustomerDetailView(viewModel: DefaultCustomerDetailViewModel(), leadData: leadData)
    }
}

