//
//  LeadGenerationNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultLeadGenerationNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentLeadGenDetailView(leadData: LeadList?) -> some View {
        LeadGenDetailsView(viewModel: DefaultLeadGenDetailsViewModel(), leadData: leadData)
    }
    
    @ViewBuilder
    func presentNewLeadGenView() -> some View {
        AddNewLead(viewModel: DefaultAddNewLeadViewModel())
    }
}
