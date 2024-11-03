//
//  ProfileViewModel.swift
//  Manage
//
//  Created by Vasim Khan on 10/29/24.
//

import Combine
import Resolver
import Domain
import Data
import SwiftUI

protocol ProfileViewModel: ObservableObject {
    var profileData: [ProfileData] { get set }
}

class DefaultProfileViewModel: ProfileViewModel {
    @Published var profileData: [ProfileData] = ProfileData.dummyData
}
