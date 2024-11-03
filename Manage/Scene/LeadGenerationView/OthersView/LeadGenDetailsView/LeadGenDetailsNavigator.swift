//
//  LeadGenDetailsNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultLeadGenDetailsNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentEditLeadGenView(leadData: LeadList?) -> some View {
        LeadGenEditView(viewModel: DefaultLeadGenEditViewModel(), leadData: leadData ?? LeadList(firstName: "", middleName: "", lastName: "", contactNumber: "", specialty: "", hospitalName: "", hospitalContactNumber: "", addressLine1: "", addressLine2: "", landmark: "", state: "", city: "", pin: "", purpose: "", note: "", status: ""))
    }
}
