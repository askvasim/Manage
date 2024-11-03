//
//  CustomerView.swift
//  Manage
//
//  Created by Vasim Khan on 11/1/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct CustomerView<VM: CustomerViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultCustomerNavigator
    
    @State var customerData: LeadList?
    
    @State var isCustomerDetailViewPresented: Bool = false
    
    var body: some View {
        ZStack {
            CustomNavBarView(content: {
                ZStack {
                    content()
                        .onAppear {
                            AppState.shared.swipeEnabled = true
                        }
                        .onDisappear {
                            AppState.shared.swipeEnabled = false
                        }
                    
                    NavigationLink(destination: navigator.presentCustomerDetailView(leadData: customerData),
                                   isActive: $isCustomerDetailViewPresented,
                                   label: { EmptyView() })
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                
            }, title: "Customer", otherScreens: true, addBackButton: true, filterButton: true) {
                // Action
            } filterTapped: {
                // Action
                viewModel.isBottomSheetShown.toggle()
            }
            .onAppear {
                filterCustomers()
            }
            .onChange(of: viewModel.alreadyCustomer) { _, _ in
                filterCustomers()
            }
            .onChange(of: viewModel.schedule) { _, _ in
                filterCustomers()
            }
            .onChange(of: viewModel.scheduled) { _, _ in
                filterCustomers()
            }
            .onChange(of: viewModel.rejected) { _, _ in
                filterCustomers()
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
                customerCards()
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
                            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 230, maxHeight: 230)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Filter".uppercased())
                                .font(.appFont(.light, size: 10))
                                .foregroundColor(AppColor.appPrimaryFont)
                            
                            Toggle("Show already customers", isOn: $viewModel.alreadyCustomer)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show potential customers", isOn: $viewModel.schedule)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show scheduled meetings", isOn: $viewModel.scheduled)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show not our customers", isOn: $viewModel.rejected)
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
    private func customerCards() -> some View {
        ZStack {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.filteredListData, id: \.self) { customer in
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Dr. \(customer.firstName) \(customer.lastName) (\(customer.specialty))")
                            .lineLimit(1)
                            .font(.appFont(.medium, size: 20))
                            .foregroundColor(AppColor.black)
                        
                        HStack {
                            Text("\(customer.purpose), \(customer.hospitalName)")
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appGrayFontColor)
                        }
                    })
                    .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 25)
                    .background((customer.status == "Already a Customer") ? AppColor.appLightGreen : (customer.status == "Schedule meeting") ? AppColor.appLightYellow: (customer.status == "Meeting scheduled") ? AppColor.appLightBlue : AppColor.appLightRed)
                    .cornerRadius(20)
                    .onTapGesture {
                        customerData = customer
                        isCustomerDetailViewPresented = true
                    }
                }
            }
            .padding(.horizontal, 25)
            .scrollTargetLayout()
        }
    }
    
    private func filterCustomers() {
        if !viewModel.alreadyCustomer && !viewModel.schedule && !viewModel.scheduled && !viewModel.rejected {
            // Show all leaves if all toggles are off
            viewModel.filteredListData = viewModel.customerListData
        } else {
            // Filter based on the toggles
            viewModel.filteredListData = viewModel.customerListData.filter { customer in
                (customer.status == "Already a Customer" && viewModel.alreadyCustomer) ||
                (customer.status == "Schedule meeting" && viewModel.schedule) ||
                (customer.status == "Meeting scheduled" && viewModel.scheduled) ||
                (customer.status == "Rejected" && viewModel.rejected)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    CustomerView(viewModel: DefaultCustomerViewModel())
}
