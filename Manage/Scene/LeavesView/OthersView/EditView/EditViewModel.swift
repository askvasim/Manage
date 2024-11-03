//
//  EditViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol EditViewModel: ObservableObject {
    var selectedDate: Date { get set }
    var selectedLeaveType: String { get set }
    var selectedStatus: String { get set }
}

class DefaultEditViewModel: EditViewModel {
    @Published var selectedDate = Date()
    @Published var selectedLeaveType = "Sick Leave"
    @Published var selectedStatus = "Select status"
}
