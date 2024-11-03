//
//  LeadGenModel.swift
//  Domain
//
//  Created by Vasim Khan on 11/1/24.
//

import Foundation

public class LeadList: Codable, Hashable {
    public var firstName: String
    public var middleName: String
    public var lastName: String
    public var contactNumber: String
    public var specialty: String
    public var hospitalName: String
    public var hospitalContactNumber: String
    public var addressLine1: String
    public var addressLine2: String
    public var landmark: String
    public var state: String
    public var city: String
    public var pin: String
    public var purpose: String
    public var note: String
    public var status: String
    
    public init(firstName: String, middleName: String, lastName: String, contactNumber: String, specialty: String, hospitalName: String, hospitalContactNumber: String, addressLine1: String, addressLine2: String, landmark: String, state: String, city: String, pin: String, purpose: String, note: String, status: String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.contactNumber = contactNumber
        self.specialty = specialty
        self.hospitalName = hospitalName
        self.hospitalContactNumber = hospitalContactNumber
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.landmark = landmark
        self.state = state
        self.city = city
        self.pin = pin
        self.purpose = purpose
        self.note = note
        self.status = status
    }

    // Hashable protocol requirements
    public static func == (lhs: LeadList, rhs: LeadList) -> Bool {
        return lhs.contactNumber == rhs.contactNumber && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(contactNumber)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }

    // Dummy Data
    public static var dummyData: [LeadList] {
        return [
            LeadList(
                firstName: "Nishant",
                middleName: "Hitendrabhai",
                lastName: "Shah",
                contactNumber: "+91 98765 43210",
                specialty: "Orthopedic",
                hospitalName: "Apollo",
                hospitalContactNumber: "+91 98765 43210",
                addressLine1: "Meril Corporate Office, Muktanand Marg",
                addressLine2: "Chala",
                landmark: "Bilakhia Stadium",
                state: "Gujarat",
                city: "Vapi",
                pin: "396191",
                purpose: "Hospital Visit",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna.",
                status: "Already a Customer"
            ),
            LeadList(
                firstName: "Keval",
                middleName: "Hitendrabhai",
                lastName: "Shah",
                contactNumber: "+91 98765 43210",
                specialty: "Orthopedic",
                hospitalName: "Apollo",
                hospitalContactNumber: "+91 98765 43210",
                addressLine1: "Meril Corporate Office, Muktanand Marg",
                addressLine2: "Chala",
                landmark: "Bilakhia Stadium",
                state: "Gujarat",
                city: "Vapi",
                pin: "396191",
                purpose: "Hospital Visit",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna.",
                status: "Schedule meeting"
            ),
            LeadList(
                firstName: "Sam",
                middleName: "Adam",
                lastName: "Goodenough",
                contactNumber: "+91 98765 43210",
                specialty: "Orthopedic",
                hospitalName: "Apollo",
                hospitalContactNumber: "+91 98765 43210",
                addressLine1: "Meril Corporate Office, Muktanand Marg",
                addressLine2: "Chala",
                landmark: "Bilakhia Stadium",
                state: "Gujarat",
                city: "Vapi",
                pin: "396191",
                purpose: "Hospital Visit",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna.",
                status: "Meeting scheduled"
            ),
            LeadList(
                firstName: "Brad",
                middleName: "Samual",
                lastName: "Pitt",
                contactNumber: "+91 98765 43210",
                specialty: "Orthopedic",
                hospitalName: "Apollo",
                hospitalContactNumber: "+91 98765 43210",
                addressLine1: "Meril Corporate Office, Muktanand Marg",
                addressLine2: "Chala",
                landmark: "Bilakhia Stadium",
                state: "Gujarat",
                city: "Vapi",
                pin: "396191",
                purpose: "Hospital Visit",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed sagittis leo, quis ornare urna.",
                status: "Rejected"
            )
        ]
    }
}
