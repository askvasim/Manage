//
//  CustomHelpers.swift
//  Manage
//
//  Created by Vasim Khan on 11/2/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

// Custom dropdown for Leave Type
struct PickerMenu: View {
    let label: String
    @Binding var selectedOption: String
    var fontColor: Color
    let leaveTypes = ["Select a leave type", "Sick Leave", "Casual Leave"]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Picker(label, selection: $selectedOption) {
                    ForEach(leaveTypes, id: \.self) { leave in
                        Text(leave).tag(leave)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(fontColor)
                Spacer()
            }
        }
    }
}

struct PickerStatus: View {
    let label: String
    @Binding var selectedOption: String
    var fontColor: Color
    let leaveTypes = ["Select status", "Approved", "Pending", "Rejected"]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Picker(label, selection: $selectedOption) {
                    ForEach(leaveTypes, id: \.self) { leave in
                        Text(leave).tag(leave)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(fontColor)
                Spacer()
            }
        }
    }
}

// Custom dropdown for Trip Type
struct PickerTrip: View {
    let label: String
    @Binding var selectedOption: String
    var fontColor: Color
    let leaveTypes = ["Select trip type", "Domestic", "International"]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Picker(label, selection: $selectedOption) {
                    ForEach(leaveTypes, id: \.self) { leave in
                        Text(leave).tag(leave)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(fontColor)
                Spacer()
            }
        }
    }
}

// Date Picker for Date of Leave
struct PickerDate: View {
    let label: String
    @Binding var selectedDate: Date
    var fontColor: Color
    
    var body: some View {
        DatePicker(label, selection: $selectedDate, displayedComponents: [.date])
            .padding(.leading, 14)
    }
}

// Read-only fields with configurable font color
struct ReadOnlyField: View {
    let label: String
    let text: String
    let fontColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Text(text.isEmpty ? label : text)
                    .font(.appFont(.regular, size: 17))
                    .foregroundColor(fontColor)
                Spacer()
            }
            .padding(.horizontal, 14)
        }
    }
}

// Editable fields as before
struct EditableField: View {
    let label: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(label, text: $text)
                .font(.appFont(.regular, size: 17))
                .foregroundColor((text == "") ? Color.appLightGrayFont : Color.appPrimaryFont)
                .frame(height: 44)
                .padding(.horizontal, 14)
                .background(AppColor.appPrimary)
                .keyboardType(.webSearch)
                .cornerRadius(10)
                .onSubmit { endEditingTextField() }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColor.appLightGrayFont)
                        .frame(height: 44)
                )
                .onTapGesture { endEditingTextField() }
        }
    }
}

// Editable fields as before
struct EditableNoteField: View {
    let label: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(label, text: $text)
                .lineLimit(3)
                .font(.appFont(.regular, size: 17))
                .foregroundColor((text == "") ? Color.appLightGrayFont : Color.appPrimaryFont)
                .frame(height: 44)
                .padding(.horizontal, 14)
                .background(AppColor.appPrimary)
                .keyboardType(.webSearch)
                .cornerRadius(10)
                .onSubmit { endEditingTextField() }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColor.appLightGrayFont)
                        .frame(height: 44)
                )
                .onTapGesture { endEditingTextField() }
        }
    }
}

struct PickerCity: View {
    let label: String
    @Binding var selectedOption: String
    var fontColor: Color
    let cityList = [
        "Select city",
        "Adoni",
        "Amaravati",
        "Anantapur",
        "Chandragiri",
        "Chittoor",
        "Dowlaiswaram",
        "Eluru",
        "Guntur",
        "Kadapa",
        "Kakinada",
        "Kurnool",
        "Machilipatnam",
        "Nagarjunakoṇḍa",
        "Rajahmundry",
        "Srikakulam",
        "Tirupati",
        "Vijayawada",
        "Visakhapatnam",
        "Vizianagaram",
        "Yemmiganur",
        
        // Adding major cities from different states
        "Ahmedabad", "Amritsar", "Aurangabad", "Bengaluru", "Bhopal", "Chennai", "Coimbatore",
        "Delhi", "Dhanbad", "Faridabad", "Gurgaon", "Hyderabad", "Indore", "Jaipur", "Kanpur",
        "Kolkata", "Lucknow", "Madurai", "Mangalore", "Meerut", "Mumbai", "Nagpur", "Nashik",
        "Patna", "Pune", "Raipur", "Rajkot", "Ranchi", "Surat", "Thane", "Vadodara", "Visakhapatnam",
        
        // Additional cities
        "Agra", "Ajmer", "Aligarh", "Alwar", "Ambala", "Asansol", "Bikaner", "Bhubaneswar",
        "Bikaner", "Dharamshala", "Durgapur", "Gaya", "Jabalpur", "Jodhpur", "Kota", "Kurnool",
        "Ludhiana", "Mysuru", "Nagapattinam", "Navi Mumbai", "Rourkela", "Sangli", "Solapur",
        "Tirunelveli", "Vadodara", "Vellore", "Warangal", "Yamunanagar",

        // Cities from Union Territories
        "Port Blair", "Chandigarh", "Puducherry", "Dadra and Nagar Haveli", "Daman", "Lakshadweep"
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Picker(label, selection: $selectedOption) {
                    ForEach(cityList, id: \.self) { lead in
                        Text(lead).tag(lead)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(fontColor)
                Spacer()
            }
        }
    }
}

struct PickerStates: View {
    let label: String
    @Binding var selectedOption: String
    var fontColor: Color
    let stateList = ["Select state",
                      "Andhra Pradesh",
                      "Arunachal Pradesh",
                      "Assam",
                      "Bihar",
                      "Chhattisgarh",
                      "Goa",
                      "Gujarat",
                      "Haryana",
                      "Himachal Pradesh",
                      "Jharkhand",
                      "Karnataka",
                      "Kerala",
                      "Madhya Pradesh",
                      "Maharashtra",
                      "Manipur",
                      "Meghalaya",
                      "Mizoram",
                      "Nagaland",
                      "Odisha",
                      "Punjab",
                      "Rajasthan",
                      "Sikkim",
                      "Tamil Nadu",
                      "Telangana",
                      "Tripura",
                      "Uttarakhand",
                      "Uttar Pradesh",
                      "West Bengal",
                     "Andaman and Nicobar Islands",
                     "Chandigarh",
                     "Dadra and Nagar Haveli and Daman & Diu",
                     "The Government of NCT of Delhi",
                     "Jammu & Kashmir",
                     "Ladakh",
                     "Lakshadweep",
                     "Puducherry"
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Picker(label, selection: $selectedOption) {
                    ForEach(stateList, id: \.self) { lead in
                        Text(lead).tag(lead)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(fontColor)
                Spacer()
            }
        }
    }
}

struct PickerSpeciality: View {
    let label: String
    @Binding var selectedOption: String
    var fontColor: Color
    let specialityList = [
        "Select a speciality",
        "Allergy and Immunology",
        "Anesthesiology",
        "Dermatology",
        "Emergency Medicine",
        "Family Medicine",
        "Internal Medicine",
        "Medical Genetics",
        "Neurology",
        "Neurological Surgery",
        "Obstetrics and Gynecology",
        "Ophthalmology",
        "Orthopedic Surgery",
        "Otolaryngology (ENT)",
        "Pathology",
        "Pediatrics",
        "Physical Medicine and Rehabilitation",
        "Plastic Surgery",
        "Psychiatry",
        "Radiology",
        "Surgery",
        "Thoracic Surgery",
        "Urology",
        "Vascular Surgery",
        "Cardiology",
        "Gastroenterology",
        "Hematology",
        "Oncology",
        "Pulmonary Disease",
        "Rheumatology",
        "Endocrinology",
        "Infectious Disease",
        "Nephrology",
        "Geriatrics",
        "Sports Medicine",
        "Pain Management",
        "Addiction Medicine",
        "Transplant Surgery",
        "Critical Care Medicine",
        "Nuclear Medicine",
        "Palliative Care",
        "Sleep Medicine",
        "Forensic Medicine",
        "Preventive Medicine",
        "Occupational Medicine",
        "Environmental Medicine"
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColor.appLightGrayFont.opacity(0.5))
                .frame(height: 44)
            
            HStack {
                Picker(label, selection: $selectedOption) {
                    ForEach(specialityList, id: \.self) { lead in
                        Text(lead).tag(lead)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(fontColor)
                Spacer()
            }
        }
    }
}
