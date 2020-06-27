//
//  ContactPickerDemoView.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 27/06/20.
//  Copyright © 2020 youjinp. All rights reserved.
//


import SwiftUI
import Contacts
import SwiftUIKit

struct ContactPickerDemoView: View {
    @State var contact: CNContact?
    @State var showPicker = false
    
    var body: some View {
        ZStack {
            ContactPicker(
                showPicker: $showPicker,
                onSelectContact: {c in
                    self.contact = c})
            VStack{
                Spacer()
                Button(action: {
                    self.showPicker.toggle()
                }) {
                    Text("Pick a contact")
                }
                Spacer()
                Text("\(self.contact?.givenName ?? "")")
                Spacer()
            }
        }
    }
}

struct ContactPickerDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactPickerDemoView()
    }
}
