//
//  DetailsNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultDetailsNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentRequestLeaveView(leaveData: LeavesList?, index: Int?) -> some View {
        EditView(viewModel: DefaultEditViewModel(), leaveData: leaveData ?? LeavesList(reason: "", leaveType: "", dateOfApplication: Date(), dateOfLeave: Date(), reportionHead: "", employeeName: "", employeeCode: "", status: ""), indexValue: index)
    }
}
