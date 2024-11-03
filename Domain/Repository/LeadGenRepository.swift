//
//  LeadGenRepository.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine

public protocol LeadGenRepository {
    func leadGenView() -> AnyPublisher<LeadList, Error>
}
