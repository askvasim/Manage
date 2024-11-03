//
//  ManageApp.swift
//  Manage
//
//  Created by Vasim Khan on 10/22/24.
//

import SwiftUI
import Data
import Domain
import Resolver
import SwiftData

@main
struct ManageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: DefaultSplashViewModel())
                .environmentObject(appState)
        }
        .modelContainer(for: [LeavesList.self])
    }
}

final class AppState: ObservableObject {
    static let shared = AppState()
    @Published var rootViewId = UUID()
    @Published var swipeEnabled = true
}
