//
//  CustomerDetailViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol CustomerDetailViewModel: ObservableObject {
    var leadData: LeadList? { get set }
}

class DefaultCustomerDetailViewModel: CustomerDetailViewModel {
    @Published var leadData: LeadList? = LeadList.dummyData.first
}
