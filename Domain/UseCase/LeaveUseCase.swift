//
//  LeaveUseCase.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine
import Resolver

public protocol LeaveUseCase {
    func leaveView() -> AnyPublisher<LeavesList, Error>
}

public final class DefaultLeaveUseCase: LeaveUseCase {
    
    @Injected private var leaveRepository: LeaveRepository
    
    public init() {}
    
    public func leaveView() -> AnyPublisher<LeavesList, Error> {
        return self.leaveRepository.leaveView()
    }
}
