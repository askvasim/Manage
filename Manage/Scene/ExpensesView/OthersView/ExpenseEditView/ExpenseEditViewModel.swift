//
//  ExpenseEditViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol ExpenseEditViewModel: ObservableObject {
    var selectedDate: Date { get set }
    var selectedExpenseType: String { get set }
}

class DefaultExpenseEditViewModel: ExpenseEditViewModel {
    @Published var selectedDate = Date()
    @Published var selectedExpenseType = "Domestic"
}
