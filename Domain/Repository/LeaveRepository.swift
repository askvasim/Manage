//
//  LeaveRepository.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine

public protocol LeaveRepository {
    func leaveView() -> AnyPublisher<LeavesList, Error>
}
