//
//  ExpensesNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultExpensesNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentAddNewExpenseView() -> some View {
        AddNewExpense(viewModel: DefaultAddNewExpenseViewModel())
    }
    
    @ViewBuilder
    func presentExpenseDetailsView(expenseData: ExpenseList?) -> some View {
        ExpenseDetailsView(viewModel: DefaultExpenseDetailsViewModel(), expenseData: expenseData)
    }
}

