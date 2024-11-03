//
//  ExpenseDetailsView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct ExpenseDetailsView<VM: ExpenseDetailsViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultExpenseDetailsNavigator
    
    @State var expenseData: ExpenseList?
    
    @State var isEditLeaveViewPresented: Bool = false
    
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
                
                NavigationLink(destination: navigator.presentEditExpenseView(expenseData: expenseData ?? ExpenseList(tripDetail: "", tripType: "", dateOfApplication: Date(), dateOfTrip: Date(), note: "", reportingHead: "", employeeName: "", employeeCode: "", status: "")),
                               isActive: $isEditLeaveViewPresented,
                               label: { EmptyView() })
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }, title: "Details", greetings: "", userName: "", userProfile: "", homeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: true, deleteButton: false, shouldPerformBack: true) {
            // Action
        } stopTapped: {
            // Action
        } startTapped: {
            // Action
        } filterTapped: {
            // Action
        } editTapped: {
            // Action
            isEditLeaveViewPresented = true
        } deleteTapped: {
            // Action
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            detailsView()
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func detailsView() -> some View {
        VStack(alignment: .leading, spacing: 22) {
            DetailRow(label: "Trip Detail", text: expenseData?.tripDetail ?? "", fontSize: 22)
            DetailRow(label: "Trip Type", text: expenseData?.tripType ?? "")
            DetailRow(label: "Date of application", text: formattedDate(expenseData?.dateOfApplication ?? Date()))
            DetailRow(label: "Date of Trip", text: formattedDate(expenseData?.dateOfTrip ?? Date()))
            DetailRow(label: "Note", text: expenseData?.note ?? "")
            DetailRow(label: "Reporting Head", text: expenseData?.reportingHead ?? "")
            DetailRow(label: "Employee Name", text: expenseData?.employeeName ?? "")
            DetailRow(label: "Employee Code", text: expenseData?.employeeCode ?? "")
            DetailRow(label: "Expense Request Status", text: expenseData?.status ?? "")
            
            Spacer()
            
            Rectangle()
                .foregroundColor(AppColor.appPrimary)
        }
        .padding(.horizontal, 25)
    }
    
        private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
}

#Preview {
    ExpenseDetailsView(viewModel: DefaultExpenseDetailsViewModel())
}
