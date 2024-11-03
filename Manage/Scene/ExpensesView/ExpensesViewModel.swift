//
//  ExpensesViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol ExpensesViewModel: ObservableObject {
    var expenseListData: [ExpenseList] { get set }
    var filteredExpenseListData: [ExpenseList] { get set }
    var isBottomSheetShown: Bool { get set }
    var approvedExpense: Bool { get set }
    var pendingExpense: Bool { get set }
    var rejectedExpense: Bool { get set }
}

class DefaultExpensesViewModel: ExpensesViewModel {
    @Published var expenseListData: [ExpenseList] = ExpenseList.dummyData
    @Published var filteredExpenseListData: [ExpenseList] = []
    @Published var isBottomSheetShown: Bool = false
    @Published var approvedExpense: Bool = true
    @Published var pendingExpense: Bool = true
    @Published var rejectedExpense: Bool = true
}
