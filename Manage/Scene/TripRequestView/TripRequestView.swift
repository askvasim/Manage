//
//  TripRequestView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct TripRequestView<VM: TripRequestViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultTripRequestNavigator

    @State var tripData: TripList?
    @State var isNewTripViewPresented: Bool = false
    @State var isTripDetailViewPresented: Bool = false

    var body: some View {
        ZStack {
            CustomNavBarView(content: {
                ZStack {
                    content()
                        .onAppear { AppState.shared.swipeEnabled = true }
                        .onDisappear { AppState.shared.swipeEnabled = false }

                    NavigationLink(destination: navigator.presentNewTripView(),
                                   isActive: $isNewTripViewPresented,
                                   label: { EmptyView() })

                    NavigationLink(destination: navigator.presentTripDetailsView(tripList: tripData),
                                   isActive: $isTripDetailViewPresented,
                                   label: { EmptyView() })
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }, title: "Trip Requests", otherScreens: true, addBackButton: true, filterButton: true) {
                viewModel.isBottomSheetShown.toggle()
            }
            .onAppear {
                filterTrip()
            }
            .onChange(of: viewModel.approvedTrip) { _, _ in
                filterTrip()
            }
            .onChange(of: viewModel.pendingTrip) { _, _ in 
                filterTrip()
            }
            .onChange(of: viewModel.rejectedTrip) { _, _ in
                filterTrip()
            }
            
            // Floating "+" Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isNewTripViewPresented = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: 56, height: 56)
                                .foregroundColor(AppColor.appPrimary)
                                .padding(.trailing, 25)
                            
                            Image("ic_add")
                                .resizable()
                                .frame(width: 56, height: 56)
                                .foregroundColor(AppColor.appPrimaryFont)
                                .padding(.trailing, 25)
                        }
                    }
                }
                .padding(.bottom, 10)
            }
        }
        .sheet(isPresented: $viewModel.isBottomSheetShown) {
            filterSheet()
        }
    }

    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                tripCards()
            }
            .padding(.top, 10)
        }
    }

    private func filterSheet() -> some View {
        ZStack {
            AppColor.appPrimary.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                ZStack(alignment: .center) {
                    Text("Filter".uppercased())
                        .font(.appFont(.regular, size: 14))
                    
                    HStack {
                        Button {
                            viewModel.isBottomSheetShown.toggle()
                        } label: {
                            Image("ic_add_plus")
                                .resizable()
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appPrimaryFont)
                                .rotationEffect(.degrees(45))
                                .frame(width: 22, height: 22)
                        }
                        Spacer()
                    }
                }
                .padding(.top, 18)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .foregroundColor(AppColor.appGrayBackground)
                            .frame(maxWidth: .infinity, idealHeight: 168)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Filter".uppercased())
                                .font(.appFont(.light, size: 10))
                                .foregroundColor(AppColor.appPrimaryFont)
                            
                            Toggle("Show approved trips", isOn: $viewModel.approvedTrip)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show pending trips", isOn: $viewModel.pendingTrip)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show rejected trips", isOn: $viewModel.rejectedTrip)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                        }
                        .padding(.horizontal, 20)
                    }
                }
                Spacer()
            }
        }
        .presentationDetents([.large, .large])
    }

    @ViewBuilder
    private func tripCards() -> some View {
        ZStack {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.filteredTripListData, id: \.self) { trip in
                    ZStack {
                        Image(trip.eventImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, idealHeight: 170)
                            .cornerRadius(20)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(trip.eventName)
                                        .font(.appFont(.medium, size: 16))
                                        .foregroundColor(AppColor.appPrimary)
                                    
                                    HStack {
                                        Text("\(formattedDate(trip.eventStartDate)) - \(formattedDate(trip.eventEndDate))")
                                            .font(.appFont(.regular, size: 10))
                                            .foregroundColor(AppColor.appPrimary)
                                        
                                        Text("|")
                                            .font(.appFont(.regular, size: 10))
                                            .foregroundColor(AppColor.appPrimary)
                                        
                                        Text("\(trip.city), \(trip.country)")
                                            .font(.appFont(.regular, size: 10))
                                            .foregroundColor(AppColor.appPrimary)
                                    }
                                    .padding(.bottom, 15)
                                }
                                
                                Spacer()
                            }
                            .padding(.leading, 20)
                            .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                        .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 182, idealHeight: 182,maxHeight: 182)
                        .background(
                            LinearGradient(colors: [AppColor.appPrimaryFont.opacity(0.0), AppColor.appPrimaryFont.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(20)
                        .onTapGesture {
                            tripData = trip
                            isTripDetailViewPresented = true
                        }
                    }
                }
            }
            .padding(.horizontal, 25)
        }
    }

    private func filterTrip() {
        if !viewModel.approvedTrip && !viewModel.pendingTrip && !viewModel.rejectedTrip {
            viewModel.filteredTripListData = viewModel.tripListData
        } else {
            viewModel.filteredTripListData = viewModel.tripListData.filter { lead in
                (lead.status == "Approved" && viewModel.approvedTrip) ||
                (lead.status == "Pending" && viewModel.pendingTrip) ||
                (lead.status == "Rejected" && viewModel.rejectedTrip)
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
}

#Preview {
    TripRequestView(viewModel: DefaultTripRequestViewModel())
}
