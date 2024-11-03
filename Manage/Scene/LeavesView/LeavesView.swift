//
//  LeavesView.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI
import Domain
import Resolver
import Combine
import SwiftData

struct LeavesView<VM: LeaveViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultLeaveNavigator
    
    @Environment(\.modelContext) var context
    @State var leaveData: LeavesList?
    @State var indexValue: Int?
    @State var isFromHomeScreen: Bool? = false
    
    @Query(sort: \LeavesList.dateOfLeave) var leaveListData: [LeavesList]
//    @State var filteredLeaveListData: [LeavesList] = []
    
    @State var isRequestLeaveViewPresented: Bool = false
    @State var isRequestDetailViewPresented: Bool = false
    
    var body: some View {
//        NavigationView {
            ZStack {
                CustomNavBarView(content: {
                    ZStack {
                        content()
                            .onAppear {
                                if isFromHomeScreen ?? false {
                                    AppState.shared.swipeEnabled = true
                                }
                            }
                            .onDisappear {
                                AppState.shared.swipeEnabled = false
                            }
                        
                        NavigationLink(destination: navigator.presentRequestLeaveView(),
                                       isActive: $isRequestLeaveViewPresented,
                                       label: { EmptyView() })
                        
                        NavigationLink(destination: navigator.presentDetailsView(leaveData: leaveData, index: indexValue),
                                       isActive: $isRequestDetailViewPresented,
                                       label: { EmptyView() })
                    }
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                    
                }, title: "Leave Application", otherScreens: true, addBackButton: isFromHomeScreen, filterButton: true) {
                    // Action
                } filterTapped: {
                    // Action
                    viewModel.isBottomSheetShown.toggle()
                }
                .onAppear {
                    filterLeaves()
                }
                .onChange(of: viewModel.approvedLeaves) { _, _ in
                    filterLeaves()
                }
                .onChange(of: viewModel.pendingLeaves) { _, _ in
                    filterLeaves()
                }
                .onChange(of: viewModel.rejectedLeaves) { _, _ in
                    filterLeaves()
                }
                
                // Floating "+" Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // Action for adding a new leave
                            isRequestLeaveViewPresented = true
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
//        }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                leavesCards()
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
                            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 168, maxHeight: 168)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Filter".uppercased())
                                .font(.appFont(.light, size: 10))
                                .foregroundColor(AppColor.appPrimaryFont)
                            
                            Toggle("Show approved leaves", isOn: $viewModel.approvedLeaves)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show pending leaves", isOn: $viewModel.pendingLeaves)
                                .toggleStyle(SwitchToggleStyle(tint: Color.appPrimaryFont))
                            
                            Toggle("Show rejected leaves", isOn: $viewModel.rejectedLeaves)
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
    private func leavesCards() -> some View {
        ZStack {
            LazyVStack(spacing: 20) {
                ForEach(Array(viewModel.filteredLeaveListData.enumerated()), id: \.element) { index, leaves in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(leaves.reason)
                            .font(.appFont(.medium, size: 20))
                            .foregroundColor(AppColor.black)
                        
                        HStack {
                            Text(leaves.leaveType)
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appGrayFontColor)
                            
                            Text("|")
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appGrayFontColor)
                            
                            Text(formattedDate(leaves.dateOfLeave))
                                .font(.appFont(.regular, size: 14))
                                .foregroundColor(AppColor.appGrayFontColor)
                        }
                    }
                    .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 25)
                    .background(leaves.status == "Approved" ? AppColor.appLightGreen : leaves.status == "Pending" ? AppColor.appLightYellow : AppColor.appLightRed)
                    .cornerRadius(20)
                    .onTapGesture {
                        indexValue = index
                        leaveData = leaves
                        isRequestDetailViewPresented = true
                    }
                }
            }
            .padding(.horizontal, 25)
            .scrollTargetLayout()
        }
    }
    
    private func filterLeaves() {
        if !viewModel.approvedLeaves && !viewModel.pendingLeaves && !viewModel.rejectedLeaves {
            // Show all leaves if all toggles are off
            viewModel.filteredLeaveListData = leaveListData
        } else {
            // Filter based on the toggles
            viewModel.filteredLeaveListData = leaveListData.filter { leave in
                (leave.status == "Approved" && viewModel.approvedLeaves) ||
                (leave.status == "Pending" && viewModel.pendingLeaves) ||
                (leave.status == "Rejected" && viewModel.rejectedLeaves)
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
    LeavesView(viewModel: DefaultLeaveViewModel())
}
