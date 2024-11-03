//
//  TripRequestDetailsNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultTripRequestDetailsNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentEditTripView(tripData: TripList) -> some View {
        TripRequestEdit(viewModel: DefaultTripRequestEditViewModel(), tripData: TripList(eventImage: "", eventName: "", exhibitionName: "", city: "", country: "", aboutEvent: "", eventStartDate: Date(), eventEndDate: Date(), dateOfApplication: Date(), dateOfTrip: Date(), eventVenue: "", reportingHead: "", employeeName: "", employeeCode: "", status: "", tripType: ""), profilePicture: UIImage(named: "") ?? UIImage())
    }
}
