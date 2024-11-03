//
//  AddNewTripViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol AddNewTripViewModel: ObservableObject {
    var tripData: TripList { get set }
    var selectedExpenseType: String { get set }
}

class DefaultAddNewTripViewModel: AddNewTripViewModel {
    @Published var tripData: TripList = TripList(eventImage: "", eventName: "", exhibitionName: "", city: "", country: "", aboutEvent: "", eventStartDate: Date(), eventEndDate: Date(), dateOfApplication: Date(), dateOfTrip: Date(), eventVenue: "", reportingHead: "", employeeName: "", employeeCode: "", status: "", tripType: "")
    @Published var selectedExpenseType = "Domestic"
}
