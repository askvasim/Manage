//
//  CustomerViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol CustomerViewModel: ObservableObject {
    var customerListData: [LeadList] { get set }
    var filteredListData: [LeadList] { get set }
    
    var isBottomSheetShown: Bool { get set }
    var alreadyCustomer: Bool { get set }
    var schedule: Bool { get set }
    var scheduled: Bool { get set }
    var rejected: Bool { get set }
}

class DefaultCustomerViewModel: CustomerViewModel {
    @Published var customerListData: [LeadList] = LeadList.dummyData
    @Published var filteredListData: [LeadList] = []
    
    @Published var isBottomSheetShown: Bool = false
    @Published var alreadyCustomer: Bool = true
    @Published var schedule: Bool = true
    @Published var scheduled: Bool = true
    @Published var rejected: Bool = true
}
