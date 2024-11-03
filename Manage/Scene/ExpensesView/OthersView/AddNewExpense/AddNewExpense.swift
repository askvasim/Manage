//
//  AddNewExpense.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct AddNewExpense<VM: AddNewExpenseViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultAddNewExpenseNavigator
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
            
        }, title: "Add Expense", greetings: "", userName: "", userProfile: "", homeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: true, shouldPerformBack: true) {
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
            editFields(expenseData: viewModel.expenseData)
            Spacer()
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func editFields(expenseData: ExpenseList) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            EditableField(label: "Trip Details", text: $viewModel.expenseData.tripDetail)
            
            // Dropdown Picker for trip Type
            PickerTrip(label: "Trip Type", selectedOption: $viewModel.selectedTripType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedTripType) { newValue, oldValue in
                    viewModel.expenseData.tripType = newValue
                }
            
            // Display current date for Date of Application
            ReadOnlyField(label: "Date of Application", text: formattedDate(expenseData.dateOfApplication), fontColor: AppColor.appPrimaryFont)
            
            // Date Picker for Date of Expense
            PickerDate(label: "Date of trip", selectedDate: $viewModel.expenseData.dateOfTrip, fontColor: AppColor.appPrimaryFont)
            
            EditableField(label: "Note", text: $viewModel.expenseData.note)
            
            // Read-only fields for Reporting Head, Employee Name, Employee ID (mocked for this example)
            ReadOnlyField(label: "Reporting Head", text: expenseData.reportingHead, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee Name", text: expenseData.employeeName, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee ID", text: expenseData.employeeCode, fontColor: AppColor.appLightGrayFont)
            
            Spacer()
            
            // Save Button to save the data
            Button(action: saveExpenseRequest) {
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
    
    private func saveExpenseRequest() {
        print("Expense request submitted: \(viewModel.expenseData)")
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    AddNewExpense(viewModel: DefaultAddNewExpenseViewModel())
}
