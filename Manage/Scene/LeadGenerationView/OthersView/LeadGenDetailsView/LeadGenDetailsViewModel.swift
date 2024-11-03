//
//  LeadGenDetailsViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol LeadGenDetailsViewModel: ObservableObject {
    var leadData: LeadList? { get set }
}

class DefaultLeadGenDetailsViewModel: LeadGenDetailsViewModel {
    @Published var leadData: LeadList? = LeadList.dummyData.first
}
