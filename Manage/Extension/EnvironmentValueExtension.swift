//
//  EnvironmentValueExtension.swift
//  Manage
//
//  Created by Vasim Khan on 10/20/24.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKeyCustom.self]
    }
}

@available(iOS 15.0, *)
public struct SafeAreaInsetsKeyCustom: EnvironmentKey {
    public static var defaultValue: EdgeInsets {
        UIApplication.shared.currentUIWindow()?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

@available(iOS 15.0, *)
public extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
