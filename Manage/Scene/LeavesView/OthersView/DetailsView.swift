//
//  DetailsView.swift
//  Manage
//
//  Created by Vasim Khan on 10/27/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct DetailsView<VM: DetailsViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultDetailsNavigator
    
    @State var leaveData: LeavesList?
    @State var indexValue: Int?
    
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
                
                NavigationLink(destination: navigator.presentRequestLeaveView(leaveData: leaveData, index: indexValue),
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
            isEditLeaveViewPresented.toggle()
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
            DetailRow(label: "Reason", text: leaveData?.reason ?? "", fontSize: 22)
            DetailRow(label: "Leave Type", text: leaveData?.leaveType ?? "")
            DetailRow(label: "Date of application", text: formattedDate(leaveData?.dateOfApplication ?? Date()))
            DetailRow(label: "Date of leave", text: formattedDate(leaveData?.dateOfLeave ?? Date()))
            DetailRow(label: "Reporting Head", text: leaveData?.reportionHead ?? "")
            DetailRow(label: "Employee Name", text: leaveData?.employeeName ?? "")
            DetailRow(label: "Employee Code", text: leaveData?.employeeCode ?? "")
            DetailRow(label: "Leave Request Status", text: leaveData?.status ?? "")
            
            Spacer()
            
            Rectangle()
                .foregroundColor(AppColor.appPrimary)
        }
        .padding(.horizontal, 25)
    }
    
    // Function to format date to string
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let label: String
    let text: String
    var fontSize: CGFloat = 16
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.appFont(.regular, size: 12))
                .foregroundColor(AppColor.appLightGrayFont)
            
            Text(text)
                .font(.appFont(.regular, size: fontSize))
                .foregroundColor(AppColor.appPrimaryFont)
        }
    }
}

#Preview {
    DetailsView(viewModel: DefaultDetailsViewModel(), leaveData: LeavesList(reason: "", leaveType: "", dateOfApplication: Date(), dateOfLeave: Date(), reportionHead: "", employeeName: "", employeeCode: "", status: ""))
}
