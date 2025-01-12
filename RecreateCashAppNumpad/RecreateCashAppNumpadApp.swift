//
//  CashAppNumpadSwiftUIApp.swift
//  CashAppNumpadSwiftUI
//
//  Created by @txmasbo on 5/1/25.
//

import SwiftUI

@main
struct RecreateCashAppNumpadApp: App {
    var body: some Scene {
        WindowGroup {
            NumpadView()
                .preferredColorScheme(.dark)
        }
    }
}
