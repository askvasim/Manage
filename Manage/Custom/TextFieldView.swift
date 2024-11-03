//
//  TextFieldView.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI
import Combine
import Domain

enum AllowedInput {
    case number, letter, alphaNumeric, everything
}

enum PlaceholderFormat {
    case capitalized, capitalizedSentence, lowercased, uppercased
}
