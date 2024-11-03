//
//  ProfileUseCase.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import Combine
import Resolver

public protocol ProfileUseCase {
    func profileScreen() -> AnyPublisher<ProfileData, Error>
}

public final class DefaultProfileUseCase: ProfileUseCase {
    
    @Injected private var profileRepository: ProfileRepository
    
    public init() {}
    
    public func profileScreen() -> AnyPublisher<ProfileData, Error> {
        return self.profileRepository.profileView()
    }
}
