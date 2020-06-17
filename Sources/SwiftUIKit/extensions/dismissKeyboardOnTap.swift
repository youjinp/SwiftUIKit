//
//  dismissKeyboardOnTap.swift
//  SwiftUIKitExampleApp
//
//  Created by Youjin Phea on 17/06/20.
//  Copyright © 2020 youjinp. All rights reserved.
//

import SwiftUI

public extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}

public struct DismissKeyboardOnTap: ViewModifier {
    public func body(content: Content) -> some View {
        #if os(macOS)
        return content
        #else
        return content.gesture(tapGesture)
        #endif
    }

    private var tapGesture: some Gesture {
        TapGesture().onEnded(endEditing)
    }

    private func endEditing() {
        UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .map {$0 as? UIWindowScene}
            .compactMap({$0})
            .first?.windows
            .filter {$0.isKeyWindow}
            .first?.endEditing(true)
    }
}

