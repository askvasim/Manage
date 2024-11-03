//
//  AttendanceView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct AttendanceView<VM: AttendanceViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultAttendanceNavigator
    
    @State private var isDayStarted: Bool = false
    @State private var isStopActive: Bool = false
    @State private var isStartActive: Bool = true
    @State private var isAlertShowing: Bool = false
    @State private var isPlayAlertShowing: Bool = false
    @State private var loginTime: Date = Date()
    @State private var logoutTime: Date?
    @State private var totalTime: String = "--"
    @State var isFromHomeScreen: Bool? = false

    var body: some View {
        ZStack {
            CustomNavBarView(content: {
                content()
                    .onAppear {
                        if isFromHomeScreen ?? false {
                            AppState.shared.swipeEnabled = true
                        }
                    }
                    .onDisappear {
                        AppState.shared.swipeEnabled = false
                    }
            }, title: "Attendance", otherScreens: true, profileScreen: false, withBackButton: false, addBackButton: isFromHomeScreen, backButton: false, stopButton: isStopActive, startButton: isStartActive, filterButton: false, editButton: false, deleteButton: false, shouldPerformBack: false) {
                // Action
            } stopTapped: {
                isAlertShowing.toggle()
            } startTapped: {
                isPlayAlertShowing.toggle()
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
                        // Action for adding a new leave
                        
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
    }

    @ViewBuilder
    private func content() -> some View {
        VStack {
            CalendarView()
            timeSheet()
        }
        .padding(.top, 20)
        
        .alert("Logout", isPresented: $isAlertShowing) {
            Button("Yes", role: .destructive) {
                logoutTime = Date()
                totalTime = calculateTotalTime(login: loginTime, logout: logoutTime!)
                isStopActive.toggle()
                isStartActive.toggle()
            }
            Button("No", role: .cancel) {
                
            }
        } message: {
            Text("Are you sure, you want to check out? \nBy checking out you will be completing \nyour work hour day.")
        }
        
        .alert("Confirm Login", isPresented: $isPlayAlertShowing) {
            Button("Allow", role: .destructive) {
                isStopActive.toggle()
                isStartActive.toggle()
            }
            Button("Don’t Allow", role: .cancel) {
            }
        } message: {
            Text("By logging in, the app will track your real-time location, including latitude and longitude. You can manage these permissions in Settings.")
        }

    }

    private func formattedTime(_ date: Date?) -> String {
        guard let date = date else { return "--" }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter.string(from: date).lowercased()
    }

    // Time Sheet
    @ViewBuilder
    private func timeSheet() -> some View {
        VStack {
            HStack {
                timeCircleView(color: .green, label: "Login:", time: formattedTime(loginTime))
                Spacer()
                timeCircleView(color: .red, label: "Logout:", time: logoutTime != nil ? formattedTime(logoutTime!) : "--")
                Spacer()
                timeCircleView(color: AppColor.appPrimaryFont, label: "Total Time:", time: totalTime)
            }
            .padding(.horizontal, 25)
            .padding(.top, 20)

            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    VStack(alignment: .leading, spacing: 70) {
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("8:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("9:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("10:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("11:00am")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("12:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("1:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("2:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("3:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("4:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("5:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
                            Rectangle()
                                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                                .foregroundColor(AppColor.appGrayStroke)
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            Text("6:00pm")
                                .font(.appFont(.regular, size: 16))
                                .foregroundColor(.appGrayFont)
                            
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
                                    .foregroundColor(.appBlackFont)
                                
                                
                                Text("09:00am - 09:45am")
                                    .font(.appFont(.regular, size: 16))
                                    .foregroundColor(.appLightGrayFont)
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 13)
                        .background(AppColor.appLightBlue)
                        .cornerRadius(20)
                        .padding(.top, 113)
                        
                        Spacer()
                    }
                    
                    VStack {
                        ZStack(alignment: .center) {
                            VStack(alignment: .center, spacing: 6) {
                                Text("Doctor Visit (Dr. Jay)")
                                    .font(.appFont(.medium, size: 16))
                                    .foregroundColor(.appBlackFont)
                                
                                
                                Text("11:00am - 12:45pm")
                                    .font(.appFont(.regular, size: 16))
                                    .foregroundColor(.appLightGrayFont)
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 13)
                        .background(AppColor.appLightGreen)
                        .cornerRadius(20)
                        .padding(.top, 290)
                        .padding(.leading, 130)
                        
                        Spacer()
                    }
                    
                    VStack {
                        ZStack(alignment: .center) {
                            VStack(alignment: .center, spacing: 6) {
                                Text("Doctor Visit (Dr. Sahani)")
                                    .font(.appFont(.medium, size: 16))
                                    .foregroundColor(.appBlackFont)
                                
                                
                                Text("02:00pm - 03:00pm")
                                    .font(.appFont(.regular, size: 16))
                                    .foregroundColor(.appLightGrayFont)
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 13)
                        .background(AppColor.appLightYellow)
                        .cornerRadius(20)
                        .padding(.top, 560)
                        .padding(.leading, 35)
                        
                        Spacer()
                    }
                }
            }
            .padding(.top, 20)
        }
    }

    private func timeCircleView(color: Color, label: String, time: String) -> some View {
        HStack {
            ZStack {
                Circle().stroke(lineWidth: 1.0).foregroundColor(color).frame(width: 8, height: 8)
                Circle().foregroundColor(color).frame(width: 4, height: 4)
            }
            Text(label).font(.appFont(.light, size: 10)).foregroundColor(.appPrimaryFont)
            Text(time).font(.appFont(.medium, size: 10)).foregroundColor(.appPrimaryFont)
        }
    }
    
    private func calculateTotalTime(login: Date, logout: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: login, to: logout)
        let totalHours = Double(components.hour ?? 0) + (Double(components.minute ?? 0) / 60.0)
        return String(format: "%.1f hrs", totalHours)
    }
}

#Preview {
    AttendanceView(viewModel: DefaultAttendanceViewModel())
}
