//
//  LeadGenerationViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol LeadGenerationViewModel: ObservableObject {
    var leadListData: [LeadList] { get set }
}

class DefaultLeadGenerationViewModel: LeadGenerationViewModel {
    @Published var leadListData: [LeadList] = LeadList.dummyData
}
