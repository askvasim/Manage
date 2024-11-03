//
//  AttendanceViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol AttendanceViewModel: ObservableObject {
    var profileData: [ProfileData] { get set }
}

class DefaultAttendanceViewModel: AttendanceViewModel {
    @Published var profileData: [ProfileData] = ProfileData.dummyData
}
