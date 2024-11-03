//
//  ProfileView.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct ProfileView<VM: ProfileViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultProfileNavigator
    
    @State var isAttendanceViewPresented: Bool = false
    @State var isLeadGenViewPresented: Bool = false
    @State var isCustomerViewPresented: Bool = false
    @State var isExpenseViewPresented: Bool = false
    @State var isLeavePresented: Bool = false
    @State var isTripViewPresented: Bool = false
    
    @State private var showSheet = false
    @State private var isPressed = false
    @State private var isImageChanges = false
    @State private var image: UIImage? = nil
    @State private var imageName: String = ""
    @State private var imageExtension: String = ""
    @State private var imageUrl: URL = .init(fileURLWithPath: "")
    @State var profilePicture: UIImage
    
    var body: some View {
        CustomNavBarView(content: {
            ZStack {
                content()
                    .onAppear {
                        AppState.shared.swipeEnabled = false
                    }
                    .onDisappear {
                        AppState.shared.swipeEnabled = true
                    }
                
                NavigationLink(destination: navigator.presentAttandenceView(isFromHomeScreen: isAttendanceViewPresented),
                               isActive: $isAttendanceViewPresented,
                               label: { EmptyView() })
                
                NavigationLink(destination: navigator.presentLeadGenView(),
                               isActive: $isLeadGenViewPresented,
                               label: { EmptyView() })
                
                NavigationLink(destination: navigator.presentCustomerConView(),
                               isActive: $isCustomerViewPresented,
                               label: { EmptyView() })
                
                NavigationLink(destination: navigator.presentExpenseView(),
                               isActive: $isExpenseViewPresented,
                               label: { EmptyView() })
                
                NavigationLink(destination: navigator.presentLeaveView(isFromHomeScreen: isLeavePresented),
                               isActive: $isLeavePresented,
                               label: { EmptyView() })
                
                NavigationLink(destination: navigator.presentTripView(),
                               isActive: $isTripViewPresented,
                               label: { EmptyView() })
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }, title: "Profile", otherScreens: false, profileScreen: true, withBackButton: false, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: false, shouldPerformBack: false) {
            // Action
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
    }
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                profile()
                
                Rectangle()
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
                    .foregroundColor(AppColor.appGrayStroke)
                    .padding(.top, 10)
                
                profileCards()
            }
            .sheet(isPresented: $showSheet) {
                CustomImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, imageName: self.$imageName, imageExtention: self.$imageExtension, imagePath: self.$imageUrl) { result in
                    if result {
                        isImageChanges = true
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 25)
        }
    }
    
    @ViewBuilder
    private func profile() -> some View {
        VStack(alignment: .center, spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                Image(uiImage: (image ?? UIImage(named: "ic_profile_picture")) ?? profilePicture)
                    .resizable()
                    .frame(width: 110, height: 110)
                    .cornerRadius(55)
                
                Button {
                    // action
                    showSheet = true
                    isPressed = true
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(AppColor.appPrimary)
                            .frame(width: 34, height: 34)
                            .shadow(color: .appPrimaryFont.opacity(0.3), radius: 20, x: 0.0, y: 3)
                        
                        Image(String("ic_pencil"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 13, height: 13)
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                }

            }
            
            VStack(alignment: .center, spacing: 5) {
                Text("Sam Goodenough")
                    .font(.appFont(.medium, size: 20))
                    .foregroundColor(AppColor.appPrimaryFont)
                
                Text("International Sales".uppercased())
                    .tracking(1)
                    .font(.appFont(.regular, size: 10))
                    .foregroundColor(AppColor.appPrimaryFont)
            }
        }
    }
    
    @ViewBuilder
    private func profileCards() -> some View {
        ZStack {
            LazyVStack(spacing: 15) {
                ForEach(viewModel.profileData, id: \.self) { value in
                    HStack(alignment: .center, spacing: 10) {
                        ZStack {
                            Circle()
                                .frame(width: 34, height: 34)
                                .foregroundColor(AppColor.appPrimaryFont)
                            
                            Image(value.icon)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(AppColor.appPrimary)
                        }
                        
                        Text(value.title)
                            .font(.appFont(.regular, size: 14))
                            .foregroundColor(AppColor.appPrimaryFont)
                    }
                    .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    .padding(.leading, 15)
                    .background(AppColor.appGrayBackground)
                    .cornerRadius(10)
                    .onTapGesture(perform: {
                        self.handleProfileSelection(value.title)
                    })
                }
            }
        }
    }
    
    private func handleProfileSelection(_ title: String) {
        switch title.uppercased() {
        case String("Attendance".uppercased()):
            print(title)
            isAttendanceViewPresented = true
        case String("Lead Generation".uppercased()):
            print(title)
            isLeadGenViewPresented = true
        case String("Customer Conversation".uppercased()):
            print(title)
            isCustomerViewPresented = true
        case String("Expense Request".uppercased()):
            print(title)
            isExpenseViewPresented = true
        case String("Leave Applications".uppercased()):
            print(title)
            isLeavePresented = true
        case String("Trip Request".uppercased()):
            print(title)
            isTripViewPresented = true
        default:
            break
        }
    }
}

#Preview {
    ProfileView(viewModel: DefaultProfileViewModel(), profilePicture: UIImage(named: "") ?? UIImage())
}
