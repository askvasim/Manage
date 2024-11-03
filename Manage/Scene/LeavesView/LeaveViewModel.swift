//
//  LeaveViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol LeaveViewModel: ObservableObject {
    var filteredLeaveListData: [LeavesList] { get set }
    
    var isBottomSheetShown: Bool { get set }
    var approvedLeaves: Bool { get set }
    var pendingLeaves: Bool { get set }
    var rejectedLeaves: Bool { get set }
}

class DefaultLeaveViewModel: LeaveViewModel {
    @Published var filteredLeaveListData: [LeavesList] = []
    
    @Published var isBottomSheetShown: Bool = false
    @Published var approvedLeaves: Bool = false
    @Published var pendingLeaves: Bool = false
    @Published var rejectedLeaves: Bool = false
}
