//
//  Resolver.swift
//  Manage
//
//  Created by Vasim Khan on 10/20/24.
//

import Foundation
import Resolver
import Domain
import Data

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // MARK: PRESENTATION LAYER
        register { DefaultProfileViewModel() }
        register { DefaultProfileNavigator() }
        register { DefaultAttendanceViewModel() }
        register { DefaultAttendanceNavigator() }
        register { DefaultAddNewTripViewModel() }
        register { DefaultAddNewTripNavigator() }
        register { DefaultTripRequestDetailsViewModel() }
        register { DefaultTripRequestDetailsNavigator() }
        register { DefaultTripRequestEditViewModel() }
        register { DefaultTripRequestEditNavigator() }
        register { DefaultTripRequestViewModel() }
        register { DefaultTripRequestNavigator() }
        register { DefaultAddNewExpenseViewModel() }
        register { DefaultAddNewExpenseNavigator() }
        register { DefaultExpenseDetailsViewModel() }
        register { DefaultExpenseDetailsNavigator() }
        register { DefaultExpenseEditViewModel() }
        register { DefaultExpenseEditNavigator() }
        register { DefaultExpensesViewModel() }
        register { DefaultExpensesNavigator() }
        register { DefaultAddNewLeadViewModel() }
        register { DefaultAddNewLeadNavigator() }
        register { DefaultLeadGenDetailsViewModel() }
        register { DefaultLeadGenDetailsNavigator() }
        register { DefaultLeadGenEditViewModel() }
        register { DefaultLeadGenEditNavigator() }
        register { DefaultLeadGenerationViewModel() }
        register { DefaultLeadGenerationNavigator() }
        register { DefaultRequestLeaveViewModel() }
        register { DefaultRequestLeaveNavigator() }
        register { DefaultDetailsViewModel() }
        register { DefaultDetailsNavigator() }
        register { DefaultEditViewModel() }
        register { DefaultEditNavigator() }
        register { DefaultLeaveViewModel() }
        register { DefaultLeaveNavigator() }
        register { DefaultHomeViewModel() }
        register { DefaultHomeNavigator() }
        register { DefaultDashboardViewModel() }
        register { DefaultDashboardNavigator() }
        register { DefaultLogInViewModel() }
        register { DefaultLogInNavigator() }
        register { DefaultOnBoardingViewModel() }
        register { DefaultOnBoardingNavigator() }
        register { DefaultSplashViewModel() }
        register { DefaultSplashNavigator() }
        register { DefaultCustomerViewModel() }
        register { DefaultCustomerNavigator() }
        register { DefaultCustomerViewModel() }
        register { DefaultCustomerDetailNavigator() }
        register { DefaultEditCustomerViewModel() }
        register { DefaultEditCustomerNavigator() }
        
        // MARK: - DOMAIN LAYER
        
        
        //MARK: - DATA LAYER
    }
}
