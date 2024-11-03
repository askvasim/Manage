//
//  TripRequestDetails.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct TripRequestDetails<VM: TripRequestDetailsViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultTripRequestDetailsNavigator
    
    @State var tripData: TripList?
    
    @State var isEditTripViewPresented: Bool = false
    
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
                
                NavigationLink(destination: navigator.presentEditTripView(tripData: tripData ?? TripList(eventImage: "", eventName: "", exhibitionName: "", city: "", country: "", aboutEvent: "", eventStartDate: Date(), eventEndDate: Date(), dateOfApplication: Date(), dateOfTrip: Date(), eventVenue: "", reportingHead: "", employeeName: "", employeeCode: "", status: "", tripType: "")),
                               isActive: $isEditTripViewPresented,
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
            isEditTripViewPresented = true
        } deleteTapped: {
            // Action
        }
    }

    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                detail()
            }
            .padding(.top, 15)
        }
    }
    
    @ViewBuilder
    private func detail() -> some View {
        VStack(alignment: .leading) {
            Image(viewModel.tripData?.eventImage ?? "")
                .resizable()
                .frame(minWidth: 300, idealWidth: 325, maxWidth: .infinity, minHeight: 170, idealHeight: 170, maxHeight: 170, alignment: .leading)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 15) {
                Text(viewModel.tripData?.exhibitionName ?? "")
                    .font(.appFont(.medium, size: 10))
                    .foregroundColor(AppColor.appPrimary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(AppColor.appPrimaryFont)
                    .cornerRadius(4)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.tripData?.eventName ?? "")
                        .font(.appFont(.bold, size: 16))
                        .foregroundColor(AppColor.appPrimaryFont)
                    
                    HStack {
                        Text("\(formattedDate(viewModel.tripData?.eventStartDate ?? Date())) - \(formattedDate(viewModel.tripData?.eventEndDate ?? Date()))")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appPrimaryFont)
                        
                        Text("|")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appPrimaryFont)
                        
                        Text("\(viewModel.tripData?.city ?? ""), \(viewModel.tripData?.country ?? "")")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(AppColor.appGrayStroke)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("About This Event")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appGrayFont)
                        
                        Text(viewModel.tripData?.aboutEvent ?? "")
                            .font(.appFont(.regular, size: 16))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Date of Trip")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appGrayFont)
                        
                        Text("\(formattedFullDate(viewModel.tripData?.eventStartDate ?? Date())) - \(formattedFullDate(viewModel.tripData?.eventEndDate ?? Date()))")
                            .font(.appFont(.regular, size: 16))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Event Venue")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appGrayFont)
                        
                        Text("\(viewModel.tripData?.eventVenue ?? ""), \(viewModel.tripData?.city ?? ""), \(viewModel.tripData?.country ?? "")")
                            .font(.appFont(.regular, size: 16))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Reporting Head")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appGrayFont)
                        
                        Text(viewModel.tripData?.reportingHead ?? "")
                            .font(.appFont(.regular, size: 16))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Leave Request Status")
                            .font(.appFont(.regular, size: 12))
                            .foregroundColor(AppColor.appGrayFont)
                        
                        Text(viewModel.tripData?.status ?? "")
                            .font(.appFont(.regular, size: 16))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 25)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
    
    private func formattedFullDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    TripRequestDetails(viewModel: DefaultTripRequestDetailsViewModel())
}
