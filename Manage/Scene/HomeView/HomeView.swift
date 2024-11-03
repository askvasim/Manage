//
//  HomeView.swift
//  Manage
//
//  Created by Vasim Khan on 10/23/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct HomeView<VM: HomeViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultHomeNavigator
    
    @State var isLeadGenViewPresented: Bool = false
    @State var isCustomerConViewPresented: Bool = false
    @State var isExpenseViewPresented: Bool = false
    @State var isLeaveViewPresented: Bool = false
    @State var isAttendanceViewPresented: Bool = false
    
    var body: some View {
//        NavigationView {
            CustomNavBarView(content: {
                ZStack {
                    content()
                        .onAppear {
                            AppState.shared.swipeEnabled = false
                        }
                        .onDisappear {
                            AppState.shared.swipeEnabled = false
                        }
                    
                    NavigationLink(destination: navigator.presentLeadGenView(),
                                   isActive: $isLeadGenViewPresented,
                                   label: { EmptyView() })
                    
                    NavigationLink(destination: navigator.presentCustomerConView(),
                                   isActive: $isCustomerConViewPresented,
                                   label: { EmptyView() })
                    
                    NavigationLink(destination: navigator.presentExpenseView(),
                                   isActive: $isExpenseViewPresented,
                                   label: { EmptyView() })
                    
                    NavigationLink(destination: navigator.presentLeaveView(isFromHomeScreen: isLeaveViewPresented),
                                   isActive: $isLeaveViewPresented,
                                   label: { EmptyView() })
                    
                    NavigationLink(destination: navigator.presentAttandenceView(isFromHomeScreen: isAttendanceViewPresented),
                                   isActive: $isAttendanceViewPresented,
                                   label: { EmptyView() })
                    
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                
            }, greetings: "Welcome", userName: "Sam Goodenoughice", userProfile: "ic_profile_picture", homeScreen: true)
//        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                CalendarView()
                
                topSquareCards()
                    .padding(.top, 15)
                
                timeSheet()
                    .padding(.top, 15)
                    .onTapGesture(perform: {
                        isAttendanceViewPresented = true
                    })
                
                bottomSquareCards()
                    .padding(.top, 15)
            }
            .padding(.top, 20)
        }
    }
    // Top Square Cards
    @ViewBuilder
    private func topSquareCards() -> some View {
            VStack {
                HStack(spacing: 25) {
                    SquareCard(bgColor: AppColor.appLightBlue, title: "Lead \nGeneration", icon: "ic_lead_generation", cardWidth:  (UIScreen.main.bounds.width - 80) / 2, cardHeight:  (UIScreen.main.bounds.width - 80) / 2)
                        .onTapGesture(perform: {
                            print("\(isLeadGenViewPresented)")
                            isLeadGenViewPresented = true
                        })
                    
                    SquareCard(bgColor: AppColor.appLightPurple, title: "Customer \nConversation", icon: "ic_customer_conversation", cardWidth:  (UIScreen.main.bounds.width - 80) / 2, cardHeight:  (UIScreen.main.bounds.width - 80) / 2)
                        .onTapGesture(perform: {
                            isCustomerConViewPresented = true
                        })
                }
            }
    }
    
    // Bottom Square Cards
    @ViewBuilder
    private func bottomSquareCards() -> some View {
            VStack {
                HStack(spacing: 25) {
                    SquareCard(bgColor: AppColor.appLightGreen, title: "Expense \nRequest", icon: "ic_expense_request", cardWidth:  (UIScreen.main.bounds.width - 80) / 2, cardHeight:  (UIScreen.main.bounds.width - 80) / 2)
                        .onTapGesture(perform: {
                            isExpenseViewPresented = true
                        })
                    
                    SquareCard(bgColor: AppColor.appLightYellow, title: "Leave \nApplications", icon: "ic_leave_applications", cardWidth:  (UIScreen.main.bounds.width - 80) / 2, cardHeight:  (UIScreen.main.bounds.width - 80) / 2)
                        .onTapGesture(perform: {
                            isLeaveViewPresented = true
                        })
                }
            }
    }
    
    @ViewBuilder
    private func timeSheet() -> some View {
        VStack {
            HStack {
                HStack(alignment: .center, spacing: 4) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.green)
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 4, height: 4)
                    }
                    
                    Text("Login:")
                        .font(.appFont(.light, size: 10))
                        .foregroundColor(AppColor.appPrimaryFont)
                    
                    Text("10:00am")
                        .font(.appFont(.medium, size: 10))
                        .foregroundColor(AppColor.appPrimaryFont)
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 4) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.red)
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 4, height: 4)
                    }
                    
                    Text("Logout:")
                        .font(.appFont(.light, size: 10))
                        .foregroundColor(AppColor.appPrimaryFont)
                    
                    Text("07:30am")
                        .font(.appFont(.medium, size: 10))
                        .foregroundColor(AppColor.appPrimaryFont)
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 4) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(AppColor.appPrimaryFont)
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .foregroundColor(AppColor.appPrimaryFont)
                            .frame(width: 4, height: 4)
                    }
                    
                    Text("Total Time:")
                        .font(.appFont(.light, size: 10))
                        .foregroundColor(AppColor.appPrimaryFont)
                    
                    Text("9.5 hrs")
                        .font(.appFont(.medium, size: 10))
                        .foregroundColor(AppColor.appPrimaryFont)
                }
            }
            .padding(.horizontal, 25)
            .padding(.top, 25)
            
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    VStack(alignment: .leading, spacing: 50) {
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("9:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(AppColor.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("10:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(AppColor.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("11:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(AppColor.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("12:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(AppColor.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 40)
                    
                    VStack {
                        ZStack(alignment: .center) {
                            VStack(alignment: .center, spacing: 6) {
                                Text("Hospital Visit (Apollo)")
                                    .font(.appFont(.medium, size: 16))
                                    .foregroundColor(AppColor.appBlackFont)
                                
                                
                                Text("09:00am - 09:45am")
                                    .font(.appFont(.regular, size: 16))
                                    .foregroundColor(AppColor.appLightGrayFont)
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 13)
                        .background(AppColor.appLightBlue)
                        .cornerRadius(20)
                        .padding(.top, 23)
                        .padding(.leading, 50)
                        
                        Spacer()
                    }
                    
                    VStack {
                        ZStack(alignment: .center) {
                            VStack(alignment: .center, spacing: 6) {
                                Text("Doctor Visit (Dr. Jay)")
                                    .font(.appFont(.medium, size: 16))
                                    .foregroundColor(AppColor.appBlackFont)
                                
                                
                                Text("11:00am - 12:45pm")
                                    .font(.appFont(.regular, size: 16))
                                    .foregroundColor(AppColor.appLightGrayFont)
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 13)
                        .background(AppColor.appLightGreen)
                        .cornerRadius(20)
                        .padding(.top, 161)
                        .padding(.leading, 90)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(.bottom, 30)
        .background(AppColor.appGrayBackground)
        .cornerRadius(20)
        .padding(.horizontal, 25)
    }
}

#Preview {
    HomeView(viewModel: DefaultHomeViewModel())
}
