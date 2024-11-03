//
//  TextFieldChecker.swift
//  Manage
//
//  Created by Vasim Khan on 10/24/24.
//

import SwiftUI
import Combine

class TextValidator: ObservableObject {
    @Published var text = ""
}

public class TextFieldChecker<T: Hashable>: ObservableObject {
    internal var numberOfCheck = 0
    @Published public fileprivate(set) var errorMessage: String?
    
    internal var boundSub: AnyCancellable?
    fileprivate var subject = PassthroughSubject<T, Never>()
    
    public var isFirstCheck: Bool { numberOfCheck == 0 }
    
    public var valid: Bool {
        errorMessage == nil
    }
    
    public init(errorMessage: String? = nil) {
        self.errorMessage = errorMessage
    }
    
     func bind(to value: T, debounceInMills debounce: Int, andValidateWith validator: @escaping (T) -> String?) {
        if boundSub == nil {
            boundSub = subject.debounce(for: .milliseconds(debounce), scheduler: RunLoop.main)
                .sink {
                    self.errorMessage = validator($0)
                    self.numberOfCheck += 1
                }
            errorMessage = validator(value)
        }
    }
    
     func doValidate(value newValue: T) {
        subject.send(newValue)
    }
}
