//
//  LeadGenUseCase.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine
import Resolver

public protocol LeadGenUseCase {
    func leadGenView() -> AnyPublisher<LeadList, Error>
}

public final class DefaultLeadGenUseCase: LeadGenUseCase {
    
    @Injected private var leadGenRepository: LeadGenRepository
    
    public init() {}
    
    public func leadGenView() -> AnyPublisher<LeadList, Error> {
        return self.leadGenRepository.leadGenView()
    }
}
