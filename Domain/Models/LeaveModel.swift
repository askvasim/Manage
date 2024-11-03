//
//  LeaveModel.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation
import SwiftData

@Model
public class LeavesList: Equatable {
    public var reason: String
    public var leaveType: String
    public var dateOfApplication: Date
    public var dateOfLeave: Date
    public var reportionHead: String
    public var employeeName: String
    public var employeeCode: String
    public var status: String

    public init(reason: String, leaveType: String, dateOfApplication: Date, dateOfLeave: Date, reportionHead: String, employeeName: String, employeeCode: String, status: String) {
        self.reason = reason
        self.leaveType = leaveType
        self.dateOfApplication = dateOfApplication
        self.dateOfLeave = dateOfLeave
        self.reportionHead = reportionHead
        self.employeeName = employeeName
        self.employeeCode = employeeCode
        self.status = status
    }
    
    // Hashable protocol requirements
    public static func == (lhs: LeavesList, rhs: LeavesList) -> Bool {
        return lhs.employeeCode == rhs.employeeCode &&
               lhs.dateOfLeave == rhs.dateOfLeave &&
               lhs.reason == rhs.reason
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(employeeCode)
        hasher.combine(dateOfLeave)
        hasher.combine(reason)
    }
    
    // Dummy Data
    public static var dummyData: [LeavesList] {
        return [
            LeavesList(
                reason: "Need leave due to high fever",
                leaveType: "Sick Leave",
                dateOfApplication: Date(),
                dateOfLeave: Date().addingTimeInterval(86400),
                reportionHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Approved"
            ),
            LeavesList(
                reason: "Need leave for family function",
                leaveType: "Casual Leave",
                dateOfApplication: Date(),
                dateOfLeave: Date().addingTimeInterval(2592000),
                reportionHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Pending"
            ),
            LeavesList(
                reason: "Need leave for family function",
                leaveType: "Casual Leave",
                dateOfApplication: Date(),
                dateOfLeave: Date().addingTimeInterval(2592000),
                reportionHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Rejected"
            )
        ]
    }
}
