//
//  ProfileModel.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation

public class ProfileData: Codable, Hashable {
    public var title: String
    public var icon: String
    
    public init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }

    // Hashable protocol requirements
    public static func == (lhs: ProfileData, rhs: ProfileData) -> Bool {
        lhs.title == rhs.title && lhs.icon == rhs.icon
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(icon)
    }
    
    // Dummy Data
    public static var dummyData: [ProfileData] {
        return [
            ProfileData(title: "Attendance", icon: "ic_attendance"),
            ProfileData(title: "Lead Generation", icon: "ic_lead_generation"),
            ProfileData(title: "Customer Conversation", icon: "ic_customer_conversation"),
            ProfileData(title: "Expense Request", icon: "ic_expense_request"),
            ProfileData(title: "Leave Applications", icon: "ic_leave_applications"),
            ProfileData(title: "Trip Request", icon: "ic_trip")
        ]
    }
}
