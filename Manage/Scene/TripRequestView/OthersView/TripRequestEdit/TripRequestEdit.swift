//
//  TripRequestEdit.swift
//  Manage
//
//  Created by Vasim Khan on 10/28/24.
//

import SwiftUI
import Domain
import Resolver
import Combine

struct TripRequestEdit<VM: TripRequestEditViewModel>: View {
    @StateObject var viewModel: VM
    @InjectedObject private var navigator: DefaultTripRequestEditNavigator
    @Environment(\.presentationMode) var presentationMode
    
    @State var tripData: TripList
    
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
                        AppState.shared.swipeEnabled = true
                    }
                    .onDisappear {
                        AppState.shared.swipeEnabled = false
                    }
                
            }
        }, title: "Edit", greetings: "", userName: "", userProfile: "", homeScreen: false, otherScreens: false, profileScreen: false, withBackButton: true, backButton: false, stopButton: false, startButton: false, filterButton: false, editButton: false, deleteButton: true, shouldPerformBack: true
        ) {
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
            presentationMode.wrappedValue.dismiss()
            presentationMode.wrappedValue.dismiss()
        }
    }

    @ViewBuilder
    private func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                editFields(tripData: viewModel.tripData)
                Spacer()
            }
            .sheet(isPresented: $showSheet) {
                CustomImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, imageName: self.$imageName, imageExtention: self.$imageExtension, imagePath: self.$imageUrl) { result in
                    if result {
                        isImageChanges = true
                    }
                }
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private func editFields(tripData: TripList) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                // Action
                showSheet = true
                isPressed = true
            } label: {
                ZStack {
                    Image(uiImage: (image ?? UIImage(named: tripData.eventImage)) ?? profilePicture)
//                    Image(tripData.eventImage)
                        .resizable()
                        .frame(minWidth: 300, idealWidth: 325, maxWidth: .infinity, minHeight: 170, idealHeight: 170, maxHeight: 170, alignment: .leading)
                        .cornerRadius(20)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(minWidth: 300, idealWidth: 325, maxWidth: .infinity, minHeight: 170, idealHeight: 170, maxHeight: 170, alignment: .leading)
                        .foregroundColor(AppColor.appPrimaryFont.opacity(0.5))
                    
                    Image("ic_edit_icon")
                        .foregroundColor(AppColor.appPrimary)
                }
            }

            EditableField(label: "Trip Name", text: .constant(tripData.eventName))
            EditableField(label: "Exibition Name", text: .constant(tripData.exhibitionName))
            
            // Dropdown Picker for Expense Type
            PickerTrip(label: "Trip Type", selectedOption: $viewModel.selectedExpenseType, fontColor: AppColor.appPrimaryFont)
                .onChange(of: viewModel.selectedExpenseType) { newValue, oldValue in
                    viewModel.tripData.tripType = newValue
                }
            
            // Display current date for Date of Application
            ReadOnlyField(label: "Date of Application", text: formattedFullDate(tripData.eventStartDate), fontColor: AppColor.appPrimaryFont)
            
            // Date Picker for Date of Expense
            PickerDate(label: "Event Start Date", selectedDate: $viewModel.tripData.eventStartDate, fontColor: AppColor.appPrimaryFont)
            PickerDate(label: "Event End Date", selectedDate: $viewModel.tripData.eventEndDate, fontColor: AppColor.appPrimaryFont)
            PickerDate(label: "Date of Trip", selectedDate: $viewModel.tripData.dateOfTrip, fontColor: AppColor.appPrimaryFont)
            
            EditableNoteField(label: "City", text: .constant(tripData.city))
            EditableNoteField(label: "Country", text: .constant(tripData.country))
            EditableNoteField(label: "Event Venue", text: .constant(tripData.eventVenue))
            EditableNoteField(label: "Note", text: .constant(tripData.aboutEvent))
            
            // Read-only fields with appLightGrayFont color
            ReadOnlyField(label: "Reporting Head", text: tripData.reportingHead, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee Name", text: tripData.employeeName, fontColor: AppColor.appLightGrayFont)
            ReadOnlyField(label: "Employee ID", text: tripData.employeeCode, fontColor: AppColor.appLightGrayFont)
            
            // Save Button to save the data
            Button(action: saveTrip) {
                Text("SAVE")
                    .font(.appFont(.bold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .padding()
                    .background(AppColor.appPrimaryFont)
                    .foregroundColor(AppColor.appPrimary)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Button(action: saveTrip) {
                Text("REQUEST TRIP")
                    .font(.appFont(.bold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .padding()
                    .background(AppColor.appPrimaryFont)
                    .foregroundColor(AppColor.appPrimary)
                    .cornerRadius(10)
            }
//            .padding(.top, 20)
        }
        .padding(.horizontal, 25)
    }
    
    private func saveTrip() {
        print("Trip request Saved: \(viewModel.tripData)")
        presentationMode.wrappedValue.dismiss()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func requestTrip() {
        print("Trip request submitted: \(viewModel.tripData)")
        presentationMode.wrappedValue.dismiss()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func formattedFullDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    TripRequestEdit(viewModel: DefaultTripRequestEditViewModel(), tripData: TripList(eventImage: "", eventName: "", exhibitionName: "", city: "", country: "", aboutEvent: "", eventStartDate: Date(), eventEndDate: Date(), dateOfApplication: Date(), dateOfTrip: Date(), eventVenue: "", reportingHead: "", employeeName: "", employeeCode: "", status: "", tripType: ""), profilePicture: UIImage(named: "") ?? UIImage())
}
