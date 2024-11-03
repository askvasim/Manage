//
//  ExpenseUseCase.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine
import Resolver

public protocol ExpenseUseCase {
    func expenseView() -> AnyPublisher<ExpenseList, Error>
}

public final class DefaultExpenseUseCase: ExpenseUseCase {
    
    @Injected private var expenseRepository: ExpenseRepository
    
    public init() {}
    
    public func expenseView() -> AnyPublisher<ExpenseList, Error> {
        return self.expenseRepository.expenseView()
    }
}
