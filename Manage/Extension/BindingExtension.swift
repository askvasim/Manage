//
//  BindingExtension.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI

extension Binding {
    func map<T>(get: @escaping (Value) -> T?, set: @escaping (T?) -> Value) -> Binding<T?> {
        Binding<T?>(
            get: {
                get(wrappedValue)
            },
            set: {
                wrappedValue = set($0)
            }
        )
    }
}

public extension Binding where Value: Hashable {
    func onValidate(checker: TextFieldChecker<Value>, debounceInMills debounce: Int = 0, validator: @escaping (Value) -> String?) -> Binding<Value> {
        DispatchQueue.main.async {
            checker.bind(to: self.wrappedValue, debounceInMills: debounce, andValidateWith: validator)
        }
        return Binding(
            get: { self.wrappedValue },
            set: { newValue in
                
                if newValue != self.wrappedValue {
                    checker.doValidate(value: newValue)
                }
                self.wrappedValue = newValue
            }
        )
    }
}
