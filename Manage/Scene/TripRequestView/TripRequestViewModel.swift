//
//  TripRequestViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol TripRequestViewModel: ObservableObject {
    var tripListData: [TripList] { get set }
    var filteredTripListData: [TripList] { get set }
    var isBottomSheetShown: Bool { get set }
    var approvedTrip: Bool { get set }
    var pendingTrip: Bool { get set }
    var rejectedTrip: Bool { get set }
}

class DefaultTripRequestViewModel: TripRequestViewModel {
    @Published var tripListData: [TripList] = TripList.dummyData
    @Published var filteredTripListData: [TripList] = []
    @Published var isBottomSheetShown: Bool = false
    @Published var approvedTrip: Bool = true
    @Published var pendingTrip: Bool = true
    @Published var rejectedTrip: Bool = true
}
