//
//  ExpenseRepository.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine

public protocol ExpenseRepository {
    func expenseView() -> AnyPublisher<ExpenseList, Error>
}
