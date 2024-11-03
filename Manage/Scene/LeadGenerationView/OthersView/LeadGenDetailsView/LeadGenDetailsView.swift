//
//  LeadGenDetailsView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct LeadGenDetailsView<VM: LeadGenDetailsViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultLeadGenDetailsNavigator
    
    @State var leadData: LeadList?
    
    @State var isEditLeadViewPresented: Bool = false
    
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
                
                NavigationLink(destination: navigator.presentEditLeadGenView(leadData: leadData),
                               isActive: $isEditLeadViewPresented,
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
            isEditLeadViewPresented.toggle()
        } deleteTapped: {
            // Action
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                detailsView()
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private func detailsView() -> some View {
        VStack(alignment: .leading, spacing: 22) {
            DetailRow(label: "Full Name", text: "Dr. \(leadData?.firstName ?? "") \(leadData?.middleName ?? "") \(leadData?.lastName ?? "")", fontSize: 22)
            DetailRow(label: "Contact Number", text: leadData?.contactNumber ?? "")
            DetailRow(label: "Specialty", text: leadData?.specialty ?? "")
            DetailRow(label: "Hospital Name", text: "\(leadData?.hospitalName ?? ""), \(leadData?.city ?? "")")
            DetailRow(label: "Hospital Contact Number", text: leadData?.hospitalContactNumber ?? "")
            DetailRow(label: "Hospital Address:", text: "\(leadData?.addressLine1 ?? ""), \nNear \(leadData?.landmark ?? ""), \(leadData?.addressLine2 ?? ""), \n\(leadData?.city ?? ""), \(leadData?.state ?? "") - \(leadData?.pin ?? "")")
            DetailRow(label: "Landmark", text: leadData?.landmark ?? "")
            DetailRow(label: "Purpose", text: leadData?.purpose ?? "")
            DetailRow(label: "Note", text: leadData?.note ?? "")
            DetailRow(label: "Status", text: leadData?.purpose ?? "")
            
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

#Preview {
    LeadGenDetailsView(viewModel: DefaultLeadGenDetailsViewModel())
}
