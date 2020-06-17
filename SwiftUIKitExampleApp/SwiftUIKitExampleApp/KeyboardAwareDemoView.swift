//
//  KeyboardAwareDemoView.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 17/06/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI
import SwiftUIKit

struct KeyboardAwareDemoView: View {
    
    @State private var text = ""
    var body: some View {
        ZStack {
            Color.white
                .dismissKeyboardOnSwipe()
                .dismissKeyboardOnTap()
            VStack {
                Text("Hello, World!")
                TextField("input", text: $text)
                    .multilineTextAlignment(.center)
                Divider()
                Spacer()
            }
            VStack {
                Spacer()
                Text("Rock")
                    .background(Color.pink)
                    .adaptToKeyboard()
            }
        }
    }
    
}
