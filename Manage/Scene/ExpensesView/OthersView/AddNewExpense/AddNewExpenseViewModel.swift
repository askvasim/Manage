//
//  AddNewExpenseViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol AddNewExpenseViewModel: ObservableObject {
    var expenseData: ExpenseList { get set }
    var selectedTripType: String { get set }
}

class DefaultAddNewExpenseViewModel: AddNewExpenseViewModel {
    @Published var expenseData: ExpenseList = ExpenseList(tripDetail: "", tripType: "Select trip type", dateOfApplication: Date(), dateOfTrip: Date(), note: "", reportingHead: "", employeeName: "", employeeCode: "", status: "")
    
    @Published var selectedTripType = "Select trip type"
}
