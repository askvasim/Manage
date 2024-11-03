//
//  AddNewLeadViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol AddNewLeadViewModel: ObservableObject {
    var leadData: LeadList { get set }
    var selectedSpecialityType: String { get set }
    var selectedStateType: String { get set }
    var selectedCityType: String { get set }
}

class DefaultAddNewLeadViewModel: AddNewLeadViewModel {
    @Published var leadData: LeadList = LeadList(firstName: "", middleName: "", lastName: "", contactNumber: "", specialty: "", hospitalName: "", hospitalContactNumber: "", addressLine1: "", addressLine2: "", landmark: "", state: "", city: "", pin: "", purpose: "", note: "", status: "")
    @Published var selectedSpecialityType = "Orthopedic"
    @Published var selectedStateType = "Gujarat"
    @Published var selectedCityType = "Vapi"
}
