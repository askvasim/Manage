//
//  CustomNavBarView.swift
//  Manage
//
//  Created by Vasim Khan on 10/20/24.
//

import SwiftUI
//<ContentView: View>
struct CustomNavBarView<ContentView: View>: View {
    @Environment(\.presentationMode) var presentationMode
    private var _makeContent: () -> ContentView
    
    private var title: String?
    private var greetings: String?
    private var userName: String?
    private var userProfile: String?

    private var homeScreen: Bool?
    private var fromHomeScreen: Bool?
    private var otherScreens: Bool?
    private var profileScreen: Bool?
    private var withBackButton: Bool?
    private var addBackButton: Bool?

    private var backButton: Bool?
    private var stopButton: Bool?
    private var startButton: Bool?
    private var filterButton: Bool?
    private var editButton: Bool?
    private var deleteButton: Bool?
    private var shouldPerformBack: Bool?

    private var backTapped: (()->())?
    private var stopTapped: (()->())?
    private var startTapped: (()->())?
    private var filterTapped: (()->())?
    private var editTapped: (()->())?
    private var deleteTapped: (()->())?
    
    init(content: @escaping () -> ContentView, 
         title: String? = nil,
         greetings: String? = nil,
         userName: String? = nil,
         userProfile: String? = nil,
         
         homeScreen: Bool? = nil,
         fromHomeScreen: Bool? = nil,
         otherScreens: Bool? = nil,
         profileScreen: Bool? = nil,
         withBackButton: Bool? = nil,
         addBackButton: Bool? = nil,
         
         backButton: Bool? = nil,
         stopButton: Bool? = nil,
         startButton: Bool? = nil,
         filterButton: Bool? = nil,
         editButton: Bool? = nil,
         deleteButton: Bool? = nil,
         shouldPerformBack: Bool? = nil,
         
         backTapped: (() -> ())? = nil,
         stopTapped: (() -> ())? = nil,
         startTapped: (() -> ())? = nil,
         filterTapped: (() -> ())? = nil,
         editTapped: (() -> ())? = nil,
         deleteTapped: (() -> ())? = nil) 
    {
        self._makeContent = content
        
        self.title = title
        self.greetings = greetings
        self.userName = userName
        self.userProfile = userProfile
        
        self.homeScreen = homeScreen
        self.fromHomeScreen = fromHomeScreen
        self.otherScreens = otherScreens
        self.profileScreen = profileScreen
        self.withBackButton = withBackButton
        self.addBackButton = addBackButton
        
        self.backButton = backButton
        self.stopButton = stopButton
        self.startButton = startButton
        self.filterButton = filterButton
        self.editButton = editButton
        self.deleteButton = deleteButton
        self.shouldPerformBack = shouldPerformBack
        
        self.backTapped = backTapped
        self.stopTapped = stopTapped
        self.startTapped = startTapped
        self.filterTapped = filterTapped
        self.editTapped = editTapped
        self.deleteTapped = deleteTapped
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if homeScreen ?? false {
                    HStack(alignment: .center) {
                        Image(userProfile ?? "")
                            .resizable()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(greetings ?? "")
                                .font(.appFont(.regular, size: 10))
                                .foregroundColor(Color.appPrimaryFontColor)
                            
                            Text(userName ?? "")
                                .font(.appFont(.medium, size: 16))
                                .foregroundColor(Color.appPrimaryFontColor)
                        }
                    }
                    .padding(.horizontal, 25)
                    Spacer()
                } else if otherScreens ?? false {
                    ZStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            if addBackButton ?? false {
                                Spacer()
                                
                                Text(title ?? "")
                                    .font(.appFont(.bold, size: 24))
                                    .foregroundColor(Color.appPrimaryFontColor)
                                
                                Spacer()
                            } else {
                                Text(title ?? "")
                                    .font(.appFont(.bold, size: 24))
                                    .foregroundColor(Color.appPrimaryFontColor)
                            }
                        }
                        
                        HStack {
                            if addBackButton ?? false {
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                    backTapped?()
                                } label: {
                                    ZStack {
                                        Image("ic_back")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                            .foregroundColor(Color.appPrimaryFontColor)
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            
                            Spacer()
                            
                            if stopButton ?? false {
                                Button {
                                    //Action
                                    stopTapped?()
                                } label: {
                                    Image("ic_stop")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            } else if startButton ?? false {
                                Button {
                                    //Action
                                    startTapped?()
                                } label: {
                                    Image("ic_play")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(Color.appPrimaryFontColor)
                                }
                            } else if filterButton ?? false {
                                Button {
                                    //Action
                                    filterTapped?()
                                } label: {
                                    Image("ic_filter")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(Color.appPrimaryFontColor)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 25)
                } else if withBackButton ?? false {
                    ZStack(alignment: .center) {
                        HStack(alignment: .center) {
                            Text(title ?? "")
                                .font(.appFont(.bold, size: 24))
                                .foregroundColor(Color.appPrimaryFontColor)
                        }
                        
                        HStack {
                            Button {
                                if shouldPerformBack ?? false {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                backTapped?()
                            } label: {
                                ZStack {
                                    Image("ic_back")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(Color.appPrimaryFontColor)
                                }
                            }
                            
                            Spacer()
                            
                            if editButton ?? false {
                                Button {
                                    // Action
                                    editTapped?()
                                } label: {
                                    ZStack {
                                        Image("ic_edit")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                            .foregroundColor(Color.appPrimaryFontColor)
                                    }
                                }
                                
                            } else if deleteButton ?? false {
                                Button {
                                    // Action
                                    deleteTapped?()
                                } label: {
                                    ZStack {
                                        Image("ic_delete")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                    }
                                }
                                
                            }
                        }
                    }
                    .padding(.horizontal, 25)
                } else if profileScreen ?? false {
                    ZStack(alignment: .center) {
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text(title ?? "")
                                .font(.appFont(.bold, size: 24))
                                .foregroundColor(Color.appPrimaryFontColor)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 25)
                }
                else if fromHomeScreen ?? false {
                    ZStack(alignment: .center) {
                        HStack(alignment: .center) {
                            Text(title ?? "")
                                .font(.appFont(.bold, size: 24))
                                .foregroundColor(Color.appPrimaryFontColor)
                        }
                        
                        HStack {
                            Button {
                                if shouldPerformBack ?? false {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                backTapped?()
                            } label: {
                                ZStack {
                                    Image("ic_back")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(Color.appPrimaryFontColor)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 25)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(Color.appPrimary)
            
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                _makeContent()
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

//#Preview {
//    CustomNavBarView()
//}

// this code is responsible for swipe back functionality on the above custom navigation bar
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if AppState.shared.swipeEnabled {
            print("BackSwipe enabled")
            return viewControllers.count > 1
        }
        print("BackSwipe disabled")
        return false
    }
    
}
