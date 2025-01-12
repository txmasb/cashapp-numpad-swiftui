//
//  KeyPad.swift
//  CashAppNumpadSwiftUI
//
//  Created by @txmasbo on 5/1/25.
//

import SwiftUI

enum KeyType {
    case number(Int)
    case delete
    case dot
}

struct KeyPad: View {
    
    @ObservedObject var viewModel: NumpadViewModel
    let keyType: KeyType
    
    var body: some View {
        Button{
            withAnimation(.spring(response: 0.3,
                                  dampingFraction: 0.65,
                                  blendDuration: 0.9)) {
                viewModel.handleKeyPress(keyType)
            }
        } label: {
            switch keyType {
            case .number(let number):
                Text("\(number)")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
            case .delete:
                Image(systemName: "chevron.left")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
            case .dot:
                Text(".")
                    .font(.title)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
            }
        }
        .frame(width: 72, height: 72)
        .contentShape(Rectangle())
        .buttonStyle(BouncyKeyStyle())
    }
}


struct BouncyKeyStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.8 : 1.0)
            .onChange(of: configuration.isPressed) {
                if configuration.isPressed {
                    let generator = UIImpactFeedbackGenerator(style: .soft)
                    generator.impactOccurred()
                }
            }
    }
}
