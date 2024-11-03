//
//  EditView.swift
//  Manage
//
//  Created by Vasim Khan on 10/27/24.
//

import SwiftUI
import Domain
import Resolver
import Combine
import SwiftData

struct EditView<VM: EditViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultEditNavigator
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.modelContext) var context
    @Query(sort: \LeavesList.dateOfLeave) var leaveListData: [LeavesList]
    @State var leaveData: LeavesList
    @State var selectedDate = Date()
    @State var selectedLeaveType = "Sick Leave"
    @State var indexValue: Int?
    
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
            context.delete(leaveListData[indexValue ?? 0])
            presentationMode.wrappedValue.dismiss()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            editFields()
            Spacer()
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func editFields() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            EditableField(label: "Reason", text: $reason)
                .onTapGesture {
                    reason = leaveData.reason
                    leaveType = leaveData.leaveType
                    dateOfApplication = leaveData.dateOfApplication
                    dateOfLeave = leaveData.dateOfLeave
                    reportionHead = leaveData.reportionHead
                    employeeName = leaveData.employeeName
                    employeeCode = leaveData.employeeCode
                    status = leaveData.status
                }
            
            // Dropdown Picker for Leave Type
            PickerMenu(label: "Leave Type", selectedOption: $selectedLeaveType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: selectedLeaveType) { newValue, oldValue in
                    leaveType = newValue
                }
                .onTapGesture {
                    reason = leaveData.reason
                    leaveType = leaveData.leaveType
                    dateOfApplication = leaveData.dateOfApplication
                    dateOfLeave = leaveData.dateOfLeave
                    reportionHead = leaveData.reportionHead
                    employeeName = leaveData.employeeName
                    employeeCode = leaveData.employeeCode
                    status = leaveData.status
                }
            
            // Display current date for Date of Application
            ReadOnlyField(label: "Date of Application", text: formattedDate(leaveData.dateOfApplication), fontColor: AppColor.appPrimaryFont)
            
            // Date Picker for Date of Leave
            PickerDate(label: "Date of Leave", selectedDate: $leaveData.dateOfLeave, fontColor: AppColor.appPrimaryFont)
                .onChange(of: leaveData.dateOfLeave) { oldValue, newValue in
                    dateOfLeave = newValue
                }
                .onTapGesture {
                    reason = leaveData.reason
                    leaveType = leaveData.leaveType
                    dateOfApplication = leaveData.dateOfApplication
                    dateOfLeave = leaveData.dateOfLeave
                    reportionHead = leaveData.reportionHead
                    employeeName = leaveData.employeeName
                    employeeCode = leaveData.employeeCode
                    status = leaveData.status
                }
            
            // Read-only fields with appLightGrayFont color
            ReadOnlyField(label: "Reporting Head", text: leaveData.reportionHead, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee Name", text: leaveData.employeeName, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee ID", text: leaveData.employeeCode, fontColor: AppColor.appLightGrayFont)
            PickerStatus(label: "Status", selectedOption: $viewModel.selectedStatus, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedStatus) { newValue in
                    status = newValue
                }
                .onTapGesture {
                    reason = leaveData.reason
                    leaveType = leaveData.leaveType
                    dateOfApplication = leaveData.dateOfApplication
                    dateOfLeave = leaveData.dateOfLeave
                    reportionHead = leaveData.reportionHead
                    employeeName = leaveData.employeeName
                    employeeCode = leaveData.employeeCode
                    status = leaveData.status
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
        .onTapGesture(perform: {
            endEditingTextField()
            
            reason = leaveData.reason
            leaveType = leaveData.leaveType
            dateOfApplication = leaveData.dateOfApplication
            dateOfLeave = leaveData.dateOfLeave
            reportionHead = leaveData.reportionHead
            employeeName = leaveData.employeeName
            employeeCode = leaveData.employeeCode
            status = leaveData.status
        })
        .padding(.horizontal, 25)
    }
    
    private func saveLeaveRequest() {
        let leave = LeavesList(reason: reason, leaveType: leaveType, dateOfApplication: dateOfApplication, dateOfLeave: dateOfLeave, reportionHead: reportionHead, employeeName: employeeName, employeeCode: employeeCode, status: status)
        
        context.delete(leaveListData[indexValue ?? 0])
        context.insert(leave)
        try! context.save()
        
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
    EditView(viewModel: DefaultEditViewModel(), leaveData: LeavesList(reason: "", leaveType: "", dateOfApplication: Date(), dateOfLeave: Date(), reportionHead: "", employeeName: "", employeeCode: "", status: ""))
}
