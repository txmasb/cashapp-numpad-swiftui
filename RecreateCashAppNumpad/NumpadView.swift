//
//  NumpadView.swift
//  CashAppNumpadSwiftUI
//
//  Created by @txmasbo on 5/1/25.
//

import SwiftUI

struct NumpadView: View {
    
    @StateObject private var viewModel = NumpadViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            NumpadHeader()
            Spacer()
            HStack(spacing: 0){
                Text(viewModel.currency)
                    .font(.system(size: 96, weight: .semibold))
                ForEach(Array(viewModel.displayArray.enumerated()), id: \.offset) { index, num in
                    if viewModel.displayArray.count >= 4 && index == viewModel.displayArray.count - 3 {
                        Text(",")
                            .font(.system(size: 80, weight: .semibold))
                            .transition(.blurReplace.combined(with: .scale))
                            .id(index)
                    }
                    Text(num)
                        .font(.system(size: 96, weight: .semibold))
                        .zIndex(Double(viewModel.displayArray.count - 1 - index))
                        .transition(
                            .blurReplace.combined(with:
                            .scale).combined(with:
                            .offset(x: viewModel.inputArray.count > 1 ? -32 : 0 ,y: 12)))
                        .id(num)
                }
            }
            .scaleEffect(viewModel.arrayScale)
            .modifier(ShakeEffect(animatableData: viewModel.shake ? 0 : 1))
            .animation(.easeInOut, value: viewModel.shake)
            .frame(maxWidth: .infinity)
            Spacer()
            CurrencySelector() /*Dummy*/
            CustomNumpad(viewModel: viewModel)
            BottomActions(viewModel: viewModel)
        }
        .foregroundStyle(.white)
        .background(Color(red: 0/255, green: 199/255, blue: 47/255))
    }
}


#Preview {
    NumpadView()
}


struct CustomNumpad: View {
    
    @ObservedObject var viewModel: NumpadViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(1..<10) { number in
                    KeyPad(viewModel: viewModel, keyType: .number(number))
                }
                KeyPad(viewModel: viewModel, keyType: .dot)
                KeyPad(viewModel: viewModel, keyType: .number(0))
                KeyPad(viewModel: viewModel, keyType: .delete)
            }
            .padding(.vertical)
        }
    }
}


public struct ShakeEffect: GeometryEffect {
    private let amount: CGFloat = 10
    private let shakesPerUnit: CGFloat = 5
    public var animatableData: CGFloat

    public init(animatableData: CGFloat) {
        self.animatableData = animatableData
    }
    
    public func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: self.amount * sin(self.animatableData * .pi * self.shakesPerUnit),
                y: 0.0
            )
        )
    }
}


// Misc Assets...
struct BottomButtonLabel: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .fontWeight(.bold)
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(.white.quinary)
            .clipShape(.capsule)
    }
}


struct CurrencySelector: View {
    var body: some View {
        HStack(spacing: 6){
            Text("USD")
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Image(systemName: "chevron.down")
                .fontWeight(.bold)
                .font(.system(size: 16))
        }
        .padding(.vertical, 10)
        .padding(.leading, 20)
        .padding(.trailing, 12)
        .background(.white.quinary)
        .clipShape(.capsule)
    }
}

struct NumpadHeader: View {
    var body: some View {
        HStack{
            Image(systemName: "viewfinder")
                .font(.system(size: 26, weight: .bold))
            Spacer()
            Image(systemName: "person.crop.circle")
                .font(.system(size: 30))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 28)
    }
}

struct BottomActions: View {
    
    @ObservedObject var viewModel: NumpadViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Button{
                // ...
            } label: {
                BottomButtonLabel(title: "Request")
            }
            Button{
                // ...
            } label: {
                BottomButtonLabel(title: "Pay")
            }
        }
        .padding(.horizontal, 28)
    }
}
