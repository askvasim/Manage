//
//  EditCustomerView.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct EditCustomerView<VM: EditCustomerViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultEditCustomerNavigator
    @Environment(\.presentationMode) var presentationMode
    
    @State var leadData: LeadList
    
    var body: some View {
        CustomNavBarView(content: {
            ZStack {
                content()
                    .onAppear {
                        AppState.shared.swipeEnabled = true
                    }
                    .onDisappear {
                        AppState.shared.swipeEnabled = false
                    }
            }
        }, title: "Edit", greetings: "", userName: "", userProfile: "", homeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: true, shouldPerformBack: true) {
            // Action
        } stopTapped: {
            // Action
        } startTapped: {
            // Action
        } filterTapped: {
            // Action
        } editTapped: {
            // Action
        } deleteTapped: {
            // Action
            presentationMode.wrappedValue.dismiss()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                editFields()
                Spacer()
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private func editFields() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            EditableField(label: "Doctor First Name", text: $leadData.firstName)
            EditableField(label: "Doctor Middle Name", text: $leadData.middleName)
            EditableField(label: "Doctor Last Name", text: $leadData.lastName)
            EditableField(label: "Contact Number", text: $leadData.contactNumber)
            
            // Dropdown Picker for lead Type
            PickerSpeciality(label: "Specialty", selectedOption: $viewModel.selectedSpecialityType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedSpecialityType) { newValue, oldValue in
                    leadData.specialty = newValue
                }
            
            EditableField(label: "Hospital Name", text: $leadData.hospitalName)
            EditableField(label: "Hospital Contact Number", text: $leadData.hospitalContactNumber)
            EditableField(label: "Address Line 1", text: $leadData.addressLine1)
            EditableField(label: "Address Line 2", text: $leadData.addressLine2)
            EditableField(label: "Landmark", text: $leadData.landmark)
            
            PickerStates(label: "State", selectedOption: $viewModel.selectedStateType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedStateType) { newValue, oldValue in
                    leadData.state = newValue
                }
            
            PickerCity(label: "City", selectedOption: $viewModel.selectedCityType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedCityType) { newValue, oldValue in
                    leadData.city = newValue
                }
            
            EditableField(label: "Pin Number", text: $leadData.pin)
            EditableField(label: "Purpose", text: $leadData.purpose)
            EditableNoteField(label: "Note", text: $leadData.note)
            
            Spacer()
            
            // Save Button to save the data
            Button(action: saveLead) {
                Text("SAVE")
                    .font(.appFont(.bold, size: 16))
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 44, idealHeight: 44, maxHeight: 44)
                    .background(AppColor.appPrimaryFont)
                    .foregroundColor(AppColor.appPrimary)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding(.horizontal, 25)
    }
    
    private func saveLead() {
        print("Lead submitted: \(leadData)")
        presentationMode.wrappedValue.dismiss()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    EditCustomerView(viewModel: DefaultEditCustomerViewModel(), leadData: LeadList(firstName: "", middleName: "", lastName: "", contactNumber: "", specialty: "", hospitalName: "", hospitalContactNumber: "", addressLine1: "", addressLine2: "", landmark: "", state: "", city: "", pin: "", purpose: "", note: "", status: ""))
}
