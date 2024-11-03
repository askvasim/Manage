//
//  ExpenseDetailsNavigator.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import SwiftUI
import Combine
import Domain

public final class DefaultExpenseDetailsNavigator: ObservableObject {
    
    init() {}
    
    @ViewBuilder
    func presentEditExpenseView(expenseData: ExpenseList) -> some View {
        ExpenseEditView(viewModel: DefaultExpenseEditViewModel(), expenseData: expenseData)
    }
}
