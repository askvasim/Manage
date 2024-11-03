//
//  TripRequestNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultTripRequestNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentNewTripView() -> some View {
        AddNewTrip(viewModel: DefaultAddNewTripViewModel(), profilePicture: UIImage(named: "") ?? UIImage())
    }
    
    @ViewBuilder
    func presentTripDetailsView(tripList: TripList?) -> some View {
        TripRequestDetails(viewModel: DefaultTripRequestDetailsViewModel(), tripData: tripList)
    }
}
