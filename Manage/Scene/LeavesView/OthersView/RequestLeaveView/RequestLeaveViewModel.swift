//
//  RequestLeaveViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol RequestLeaveViewModel: ObservableObject {
    var leaveData: LeavesList { get set }
    var selectedLeaveType: String { get set }
    var selectedStatus: String { get set }
}

class DefaultRequestLeaveViewModel: RequestLeaveViewModel {
    @Published var leaveData: LeavesList = LeavesList(reason: "", leaveType: "Select a leave type", dateOfApplication: Date(), dateOfLeave: Date(), reportionHead: "", employeeName: "", employeeCode: "", status: "")
    @Published var selectedLeaveType = "Select a leave type"
    @Published var selectedStatus = "Select status"
}
