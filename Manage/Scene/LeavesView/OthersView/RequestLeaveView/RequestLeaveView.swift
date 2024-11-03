//
//  RequestLeaveView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct RequestLeaveView<VM: RequestLeaveViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultRequestLeaveNavigator
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context
    
    @State var reason: String = ""
    @State var leaveType: String = "Select a leave type"
    @State var dateOfApplication: Date = Date()
    @State var dateOfLeave: Date = Date()
    @State var reportionHead: String = "J. D. Rangaswami"
    @State var employeeName: String = "Sam Goodenough"
    @State var employeeCode: String = "694327"
    @State private var status: String = "Select status"
    
    var body: some View {
        CustomNavBarView(content: {
            content()
                .onAppear {
                    AppState.shared.swipeEnabled = true
                }
                .onDisappear {
                    AppState.shared.swipeEnabled = false
                }
            
        }, title: "Request Leave", greetings: "", userName: "", userProfile: "", homeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: true, shouldPerformBack: true) {
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
        VStack {
            editFields(leaveData: viewModel.leaveData)
            Spacer()
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func editFields(leaveData: LeavesList) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            EditableField(label: "Reason", text: $reason)
            
            // Dropdown Picker for Leave Type
            PickerMenu(label: "Leave Type", selectedOption: $viewModel.selectedLeaveType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedLeaveType) { newValue, oldValue in
                    leaveType = newValue
                }
            
            // Display current date for Date of Application
            ReadOnlyField(label: "Date of Application", text: formattedDate(dateOfApplication), fontColor: AppColor.appPrimaryFont)
            
            // Date Picker for Date of Leave
            PickerDate(label: "Date of Leave", selectedDate: $dateOfLeave, fontColor: AppColor.appPrimaryFont)
            
            // Read-only fields for Reporting Head, Employee Name, Employee ID (mocked for this example)
            ReadOnlyField(label: "Reporting Head", text: reportionHead, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee Name", text: employeeName, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee ID", text: employeeCode, fontColor: AppColor.appLightGrayFont)
            PickerStatus(label: "Status", selectedOption: $viewModel.selectedStatus, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedStatus) { newValue in
                    status = newValue
                }
            
            Spacer()
            
            // Save Button to save the data
            Button(action: saveLeaveRequest) {
                Text("SAVE")
                    .font(.appFont(.bold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 44)
//                    .padding()
                    .background(AppColor.appPrimaryFont)
                    .foregroundColor(AppColor.appPrimary)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 25)
    }
    
    private func saveLeaveRequest() {
        print("Save Pressed")
        let leave = LeavesList(reason: reason, leaveType: leaveType, dateOfApplication: dateOfApplication, dateOfLeave: dateOfLeave, reportionHead: reportionHead, employeeName: employeeName, employeeCode: employeeCode, status: status)
        
        context.insert(leave)
        try! context.save()
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    RequestLeaveView(viewModel: DefaultRequestLeaveViewModel())
}
