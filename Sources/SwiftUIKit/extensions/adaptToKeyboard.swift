//
//  adaptToKeyboard.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 17/06/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI
import Combine

public extension View {
    func adaptToKeyboard() -> some View {
        modifier(AdaptToSoftwareKeyboard())
    }
}

// See https://gist.github.com/scottmatthewman/722987c9ad40f852e2b6a185f390f88d
public struct AdaptToSoftwareKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.spring())
            .onAppear(perform: subscribeToKeyboardEvents)
    }
    
    private func subscribeToKeyboardEvents() {
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification
        )
            .compactMap { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
            .map { $0.height }
            .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
        
        /* use these to figure out duration and animation curve (.25 & 7)
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification
        )
            .compactMap { $0.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? NSNumber }
            .subscribe(Subscribers.Sink(receiveCompletion: {_ in }, receiveValue: {print("Received: \($0)")}))
        
        
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification
        )
            .compactMap { $0.userInfo?["UIKeyboardAnimationCurveUserInfoKey"] }
            .subscribe(Subscribers.Sink(receiveCompletion: {_ in }, receiveValue: {print("Received: \($0)")}))
        */
        
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillHideNotification
        )
            .compactMap { _ in CGFloat.zero }
            .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
    }
}
