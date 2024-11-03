//
//  EditCustomerViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol EditCustomerViewModel: ObservableObject {
    var selectedSpecialityType: String { get set }
    var selectedStateType: String { get set }
    var selectedCityType: String { get set }
}

class DefaultEditCustomerViewModel: EditCustomerViewModel {
    @Published var selectedSpecialityType = "Orthopedic"
    @Published var selectedStateType = "Gujarat"
    @Published var selectedCityType = "Vapi"
}
