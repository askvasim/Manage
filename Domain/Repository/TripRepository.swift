//
//  TripRepository.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine

public protocol TripRepository {
    func tripView() -> AnyPublisher<TripList, Error>
}
