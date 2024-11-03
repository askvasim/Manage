//
//  ExpenseEditView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct ExpenseEditView<VM: ExpenseEditViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultExpenseEditNavigator
    @Environment(\.presentationMode) var presentationMode
    
    @State var expenseData: ExpenseList
    
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
            EditableField(label: "Trip Detail", text: .constant(expenseData.tripDetail))
            
            // Dropdown Picker for Expense Type
            PickerTrip(label: "Trip Type", selectedOption: $viewModel.selectedExpenseType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedExpenseType) { newValue, oldValue in
                    expenseData.tripType = newValue
                }
            
            // Display current date for Date of Application
            ReadOnlyField(label: "Date of Application", text: formattedDate(expenseData.dateOfApplication), fontColor: AppColor.appPrimaryFont)
            
            // Date Picker for Date of Expense
            PickerDate(label: "Date of Trip", selectedDate: $expenseData.dateOfTrip, fontColor: AppColor.appPrimaryFont)
            
            EditableNoteField(label: "Note", text: .constant(expenseData.note))
            
            // Read-only fields with appLightGrayFont color
            ReadOnlyField(label: "Reporting Head", text: expenseData.reportingHead, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee Name", text: expenseData.employeeName, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee ID", text: expenseData.employeeCode, fontColor: AppColor.appLightGrayFont)
            
            Spacer()
            
            // Save Button to save the data
            Button(action: saveExpense) {
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
    
    private func saveExpense() {
        print("Expense request submitted: \(expenseData)")
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
    ExpenseEditView(viewModel: DefaultExpenseEditViewModel(), expenseData: ExpenseList(tripDetail: "", tripType: "", dateOfApplication: Date(), dateOfTrip: Date(), note: "", reportingHead: "", employeeName: "", employeeCode: "", status: ""))
}
