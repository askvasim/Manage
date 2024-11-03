//
//  LeadGenerationView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct LeadGenerationView<VM: LeadGenerationViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultLeadGenerationNavigator
    
    @State var leadData: LeadList?
    
    @State var isNewLeadViewPresented: Bool = false
    @State var isLeadGenDetailViewPresented: Bool = false
    
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
                    
                    NavigationLink(destination: navigator.presentNewLeadGenView(),
                                   isActive: $isNewLeadViewPresented,
                                   label: { EmptyView() })
                    
                    NavigationLink(destination: navigator.presentLeadGenDetailView(leadData: leadData),
                                   isActive: $isLeadGenDetailViewPresented,
                                   label: { EmptyView() })
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }, title: "Lead Generation", greetings: "", userName: "", userProfile: "", homeScreen: false, fromHomeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, addBackButton: true, backButton: true, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: false, shouldPerformBack: true) {
                //Back buttom press
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
            }

            // Floating "+" Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Action for adding a new lead
                        isNewLeadViewPresented.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 28)
                                .frame(width: 56, height: 56)
                                .foregroundColor(AppColor.appPrimary)
                            
                            Image("ic_add")
                                .resizable()
                                .frame(width: 56, height: 56)
                                .foregroundColor(AppColor.appPrimaryFont)
                        }
                    }
                    .padding(.trailing, 25)
                }
                .padding(.bottom, 10)
            }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                leadCards()
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private func leadCards() -> some View {
        LazyVStack(spacing: 20) {
            ForEach(viewModel.leadListData, id: \.self) { lead in
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Dr. \(lead.firstName) \(lead.lastName) (\(lead.specialty))")
                        .lineLimit(1)
                        .font(.appFont(.medium, size: 20))
                        .foregroundColor(AppColor.appPrimaryFont)
                    
                    HStack {
                        Text("\(lead.purpose), \(lead.hospitalName)")
                            .font(.appFont(.regular, size: 14))
                            .foregroundColor(AppColor.appGrayFontColor)
                    }
                })
                .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity, alignment: .leading)
                .padding(.all, 25)
                .background(AppColor.appGrayBackground)
                .cornerRadius(20)
                .onTapGesture {
                    leadData = lead
                    isLeadGenDetailViewPresented = true
                }
            }
        }
        .padding(.horizontal, 25)
        .scrollTargetLayout()
    }
}

#Preview {
    LeadGenerationView(viewModel: DefaultLeadGenerationViewModel())
}
