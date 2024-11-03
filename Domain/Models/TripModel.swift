//
//  TripModel.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation

public class TripList: Codable, Hashable {
    public var eventImage: String
    public var eventName: String
    public var exhibitionName: String
    public var city: String
    public var country: String
    public var aboutEvent: String
    public var eventStartDate: Date
    public var eventEndDate: Date
    public var dateOfApplication: Date
    public var dateOfTrip: Date
    public var eventVenue: String
    public var reportingHead: String
    public var employeeName: String
    public var employeeCode: String
    public var status: String
    public var tripType: String
    
    public init(eventImage: String, eventName: String, exhibitionName: String, city: String, country: String, aboutEvent: String, eventStartDate: Date, eventEndDate: Date, dateOfApplication: Date, dateOfTrip: Date, eventVenue: String, reportingHead: String, employeeName: String, employeeCode: String, status: String, tripType: String) {
        self.eventImage = eventImage
        self.eventName = eventName
        self.exhibitionName = exhibitionName
        self.city = city
        self.country = country
        self.aboutEvent = aboutEvent
        self.eventStartDate = eventStartDate
        self.eventEndDate = eventEndDate
        self.dateOfApplication = dateOfApplication
        self.dateOfTrip = dateOfTrip
        self.eventVenue = eventVenue
        self.reportingHead = reportingHead
        self.employeeName = employeeName
        self.employeeCode = employeeCode
        self.status = status
        self.tripType = tripType
    }

    // Hashable protocol requirements
    public static func == (lhs: TripList, rhs: TripList) -> Bool {
        lhs.employeeCode == rhs.employeeCode &&
        lhs.eventName == rhs.eventName &&
        lhs.dateOfTrip == rhs.dateOfTrip
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(employeeCode)
        hasher.combine(eventName)
        hasher.combine(dateOfTrip)
    }

    // Dummy Data
    public static var dummyData: [TripList] {
        return [
            TripList(
                eventImage: "ic_event_thumbnail_1",
                eventName: "Medical and Health Science",
                exhibitionName: "Medical Device Exhibition",
                city: "Paris",
                country: "France",
                aboutEvent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna. Suspendisse urna ligula, mollis ac pretium ut, pretium vitae risus. Phasellus id quam id tellus ullamcorper volutpat quis sit amet sapien. Fusce a lorem molestie.",
                eventStartDate: createDate(from: "28 October 2024"),
                eventEndDate: createDate(from: "29 October 2024"),
                dateOfApplication: createDate(from: "28 October 2024"),
                dateOfTrip: createDate(from: "10 November 2024"),
                eventVenue: "Victoria Hall",
                reportingHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Approved",
                tripType: "Domestic"
            ),
            TripList(
                eventImage: "ic_event_thumbnail_2",
                eventName: "Digital Health World 2024",
                exhibitionName: "Medical Device Exhibition",
                city: "London",
                country: "UK",
                aboutEvent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna. Suspendisse urna ligula, mollis ac pretium ut, pretium vitae risus. Phasellus id quam id tellus ullamcorper volutpat quis sit amet sapien. Fusce a lorem molestie.",
                eventStartDate: createDate(from: "13 November 2024"),
                eventEndDate: createDate(from: "14 November 2024"),
                dateOfApplication: createDate(from: "28 October 2024"),
                dateOfTrip: createDate(from: "10 November 2024"),
                eventVenue: "Victoria Hall",
                reportingHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Approved",
                tripType: "Domestic"
            ),
            TripList(
                eventImage: "ic_placeholder",
                eventName: "Europe Doctors Meet",
                exhibitionName: "Medical Device Exhibition",
                city: "Amsterdam",
                country: "Netherlands",
                aboutEvent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna. Suspendisse urna ligula, mollis ac pretium ut, pretium vitae risus. Phasellus id quam id tellus ullamcorper volutpat quis sit amet sapien. Fusce a lorem molestie.",
                eventStartDate: createDate(from: "27 November 2024"),
                eventEndDate: createDate(from: "29 November 2024"),
                dateOfApplication: createDate(from: "28 October 2024"),
                dateOfTrip: createDate(from: "10 November 2024"),
                eventVenue: "Victoria Hall",
                reportingHead: "J. D. Rangaswami",
                employeeName: "Sam Goodenough",
                employeeCode: "694327",
                status: "Approved",
                tripType: "Domestic"
            )
        ]
    }

    public static func createDate(from dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: dateString) ?? Date()
    }
}
