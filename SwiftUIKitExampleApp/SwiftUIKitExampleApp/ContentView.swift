//
//  ContentView.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 5/05/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI
import SwiftUIKit

struct ContentView: View {
    @State private var value = 0.0
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CurrencyTextField("Amount", value: self.$value)
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
                }) {
                    Text("Print")
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color(hue: 0, saturation: 0, brightness: 0.9))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
