//
//  LeadGenEditViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol LeadGenEditViewModel: ObservableObject {
    var selectedSpecialityType: String { get set }
    var selectedStateType: String { get set }
    var selectedCityType: String { get set }
}

class DefaultLeadGenEditViewModel: LeadGenEditViewModel {
    @Published var selectedSpecialityType = "Orthopedic"
    @Published var selectedStateType = "Gujarat"
    @Published var selectedCityType = "Vapi"
}
