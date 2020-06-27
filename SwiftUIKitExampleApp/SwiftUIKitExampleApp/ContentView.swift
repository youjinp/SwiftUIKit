//
//  ContentView.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 5/05/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CurrencyTextFieldDemoView()) {
                    Text("Currency text field")
                }
                NavigationLink(destination: KeyboardAwareDemoView()) {
                    Text("Adapting to keyboard animation")
                }
                NavigationLink(destination: ContactPickerDemoView()) {
                    Text("Contact picker")
                }
            }.navigationBarTitle("SwiftUI Kit Demos", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
