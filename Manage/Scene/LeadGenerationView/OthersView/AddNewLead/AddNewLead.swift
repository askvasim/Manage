//
//  AddNewLead.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct AddNewLead<VM: AddNewLeadViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultAddNewLeadNavigator
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CustomNavBarView(content: {
            content()
                .onAppear {
                    AppState.shared.swipeEnabled = true
                }
                .onDisappear {
                    AppState.shared.swipeEnabled = false
                }
            
        }, title: "Add New Lead", greetings: "", userName: "", userProfile: "", homeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: true, shouldPerformBack: true) {
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
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                editFields(leadData: viewModel.leadData)
                Spacer()
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private func editFields(leadData: LeadList) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            EditableField(label: "Doctor First Name", text: $viewModel.leadData.firstName)
            EditableField(label: "Doctor Middle Name", text: $viewModel.leadData.middleName)
            EditableField(label: "Doctor Last Name", text: $viewModel.leadData.lastName)
            EditableField(label: "Contact Number", text: $viewModel.leadData.contactNumber)
            
            // Dropdown Picker for lead Type
            PickerSpeciality(label: "Specialty", selectedOption: $viewModel.selectedSpecialityType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedSpecialityType) { newValue, oldValue in
                    viewModel.leadData.specialty = newValue
                }
            
            EditableField(label: "Hospital Name", text: $viewModel.leadData.hospitalName)
            EditableField(label: "Hospital Contact Number", text: $viewModel.leadData.hospitalContactNumber)
            EditableField(label: "Address Line 1", text: $viewModel.leadData.addressLine1)
            EditableField(label: "Address Line 2", text: $viewModel.leadData.addressLine2)
            EditableField(label: "Landmark", text: $viewModel.leadData.landmark)
            
            PickerStates(label: "State", selectedOption: $viewModel.selectedStateType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedStateType) { newValue, oldValue in
                    viewModel.leadData.state = newValue
                }
            
            PickerCity(label: "City", selectedOption: $viewModel.selectedCityType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedCityType) { newValue, oldValue in
                    viewModel.leadData.city = newValue
                }
            
            EditableField(label: "Pin Number", text: $viewModel.leadData.pin)
            EditableField(label: "Purpose", text: $viewModel.leadData.purpose)
            EditableField(label: "Note", text: $viewModel.leadData.note)
            
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
        print("Lead submitted: \(viewModel.leadData)")
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    AddNewLead(viewModel: DefaultAddNewLeadViewModel())
}
