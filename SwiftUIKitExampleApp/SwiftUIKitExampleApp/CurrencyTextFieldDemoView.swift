//
//  CurrencyTextFieldDemoView.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 17/06/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI
import SwiftUIKit

struct CurrencyTextFieldDemoView: View {
    
    @State private var value: Double? = 0.0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CurrencyTextField("Amount", value: self.$value, onEditingChanged: { flag in
                    self.offset = flag ? -150 : 0
                })
                    .font(.largeTitle)
                    .multilineTextAlignment(TextAlignment.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white))
                    .shadow(radius: 15)
                    .padding()
                Button(action: {
                    print("\(self.value)")
                    UIApplication.shared.resignFirstResponder()
                }) {
                    Text("Print")
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color(hue: 0, saturation: 0, brightness: 0.9))
                
        }.offset(y: self.offset)
    }

}
