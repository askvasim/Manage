//
//  TripRequestDetailsViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol TripRequestDetailsViewModel: ObservableObject {
    var tripData: TripList? { get set }
}

class DefaultTripRequestDetailsViewModel: TripRequestDetailsViewModel {
    @Published var tripData: TripList? = TripList.dummyData.first
}
