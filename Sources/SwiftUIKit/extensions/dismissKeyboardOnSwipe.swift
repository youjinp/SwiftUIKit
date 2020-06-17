//
//  dismissKeyboardOnSwipe.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 17/06/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI

public extension View {
    func dismissKeyboardOnSwipe() -> some View { modifier(DismissKeyboardOnSwipe())
    }
}

// See https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui
public struct DismissKeyboardOnSwipe: ViewModifier {
    public func body(content: Content) -> some View {
        #if os(macOS)
        return content
        #else
        return content.gesture(swipeGesture)
        #endif
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: .global)
            .onChanged(endEditing)
    }

    private func endEditing(_ gesture: DragGesture.Value) {
        UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .map {$0 as? UIWindowScene}
            .compactMap({$0})
            .first?.windows
            .filter {$0.isKeyWindow}
            .first?.endEditing(true)
    }
}
