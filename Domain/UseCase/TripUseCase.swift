//
//  TripUseCase.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine
import Resolver

public protocol TripUseCase {
    func tripView() -> AnyPublisher<TripList, Error>
}

public final class DefaultTripUseCase: TripUseCase {
    
    @Injected private var tripRepository: TripRepository
    
    public init() {}
    
    public func tripView() -> AnyPublisher<TripList, Error> {
        return self.tripRepository.tripView()
    }
}
