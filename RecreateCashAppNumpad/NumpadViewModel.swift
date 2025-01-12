//
//  NumpadViewModel.swift
//  CashAppNumpadSwiftUI
//
//  Created by @txmasbo on 5/1/25.
//

import Foundation
import SwiftUI

class NumpadViewModel: ObservableObject {
    
    @Published var inputArray: [String] = [] {
        didSet{
            print(inputArray.joined())
        }
    }
    @Published var currency = "$"
    @Published var isValid = false
    @Published var shake = false
    
    var input: String {
        inputArray.joined()
    }
    
    var displayArray: [String] {
        inputArray.isEmpty ? ["0"] : inputArray
    }
    
    var arrayScale: CGFloat {
        max(0.8, 1 - CGFloat(inputArray.count) * 0.04)
    }
    
    func handleKeyPress(_ keyType: KeyType) {
        switch keyType {
        case .number(let number):
            if inputArray.count >= 5 || (number == 0 && inputArray.isEmpty) {
                triggerErrorFeedback()
                return
            }
            let numberString = String(number)
            inputArray.append(numberString)
            
        case .delete:
            guard !inputArray.isEmpty else {
                triggerErrorFeedback()
                return
            }
            inputArray.removeLast()
            
        case .dot:
            // Decimals logic (tbd)...
            return
        }
    }
    private func triggerErrorFeedback() {
        shake.toggle()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
}

