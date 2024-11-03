//
//  DashboardView.swift
//  Manage
//
//  Created by Vasim Khan on 10/23/24.
//

import SwiftUI
import Resolver
import Domain
import Data

struct DashboardView<VM: DashboardViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultDashboardNavigator
    
    @State var selectedTab: SelectedTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: DefaultHomeViewModel())
                .tabItem {
                    Image(selectedTab == .home ? "ic_home_filled" : "ic_home")
                    Text("Home")
                        .font(.appFont(.medium, size: 9))
                }
                .tag(SelectedTab.home)
            
            AttendanceView(viewModel: DefaultAttendanceViewModel())
                .tabItem {
                    Image(selectedTab == .attendance ? String("ic_attendance_fill") : String("ic_attendance"))
                    Text("Attendance")
                        .font(.appFont(.medium, size: 9))
                }
                .tag(SelectedTab.attendance)
            
            LeavesView(viewModel: DefaultLeaveViewModel())
                .tabItem {
                    Image(selectedTab == .leaves ? String("ic_leaves_fill") : String("ic_leaves"))
                    Text("Leaves")
                        .font(.appFont(.medium, size: 9))
                }
                .tag(SelectedTab.leaves)
            
            ProfileView(viewModel: DefaultProfileViewModel(), profilePicture: UIImage(named: "") ?? UIImage())
                .tabItem {
                    Image(selectedTab == .profile ? String("ic_profile_fill") : String("ic_profile"))
                    Text("Profile")
                        .font(.appFont(.medium, size: 9))
                }
                .tag(SelectedTab.profile)
        }
        .accentColor(Color.appPrimaryFont)
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(.appPrimary)
            UITabBar.appearance().backgroundColor = UIColor(.appPrimary)
        }
        .onAppear {
            AppState.shared.swipeEnabled = false
        }
    }
}

enum TabBarItems: String, CaseIterable {
    case home, attendance, leaves, profile
}

enum SelectedTab: Hashable {
    case home, attendance, leaves, profile
}
