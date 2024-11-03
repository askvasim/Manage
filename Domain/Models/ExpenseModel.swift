//
//  ExpenseModel.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation

public class ExpenseList: Codable, Hashable {
    public var tripDetail: String
    public var tripType: String
    public var dateOfApplication: Date
    public var dateOfTrip: Date
    public var note: String
    public var reportingHead: String
    public var employeeName: String
    public var employeeCode: String
    public var status: String
    
    public init(tripDetail: String, tripType: String, dateOfApplication: Date, dateOfTrip: Date, note: String, reportingHead: String, employeeName: String, employeeCode: String, status: String) {
        self.tripDetail = tripDetail
        self.tripType = tripType
        self.dateOfApplication = dateOfApplication
        self.dateOfTrip = dateOfTrip
        self.note = note
        self.reportingHead = reportingHead
        self.employeeName = employeeName
        self.employeeCode = employeeCode
        self.status = status
    }

    // Conforming to Hashable protocol
    public static func == (lhs: ExpenseList, rhs: ExpenseList) -> Bool {
        lhs.employeeCode == rhs.employeeCode &&
        lhs.tripDetail == rhs.tripDetail &&
        lhs.dateOfTrip == rhs.dateOfTrip
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(employeeCode)
        hasher.combine(tripDetail)
        hasher.combine(dateOfTrip)
    }

    // Dummy Data
    public static var dummyData: [ExpenseList] {
        return [
            ExpenseList(
                tripDetail: "Dubai Exhibition",
                tripType: "International",
                dateOfApplication: Date(),
                dateOfTrip: Date().addingTimeInterval(86400),
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo.",
                reportingHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Approved"
            ),
            ExpenseList(
                tripDetail: "Bangalore AIMS Visit",
                tripType: "Domestic",
                dateOfApplication: Date(),
                dateOfTrip: Date().addingTimeInterval(2592000),
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna.",
                reportingHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Pending"
            ),
            ExpenseList(
                tripDetail: "Doctor Visit Petrol Exp…",
                tripType: "Domestic",
                dateOfApplication: Date(),
                dateOfTrip: Date().addingTimeInterval(2592000),
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna.",
                reportingHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Rejected"
            )
        ]
    }
}
