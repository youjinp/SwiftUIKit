//
//  File.swift
//
//
//  Created by Youjin Phea on 5/05/20.
//

import SwiftUI
import UIKit

public struct CurrencyTextField: UIViewRepresentable {
    
    @Binding var value: Double?
    private var isResponder: Binding<Bool>?
    private var tag: Int
    private var alwaysShowFractions: Bool
    private var numberOfDecimalPlaces: Int
    private var currencySymbol: String?
    
    private var placeholder: String
    
    private var font: UIFont?
    private var foregroundColor: UIColor?
    private var accentColor: UIColor?
    private var textAlignment: NSTextAlignment?
    private var contentType: UITextContentType?
    
    private var autocorrection: UITextAutocorrectionType
    private var autocapitalization: UITextAutocapitalizationType
    private var keyboardType: UIKeyboardType
    private var returnKeyType: UIReturnKeyType
    
    private var isSecure: Bool
    private var isUserInteractionEnabled: Bool
    private var clearsOnBeginEditing: Bool
    
    private var onReturn: () -> Void
    private var onEditingChanged: (Bool) -> Void
    private var locale : Locale? = .current
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    @Environment(\.font) private var swiftUIfont: Font?
    
    public init(
        _ placeholder: String = "",
        value: Binding<Double?>,
        isResponder: Binding<Bool>? = nil,
        tag: Int = 0,
        alwaysShowFractions: Bool = false,
        numberOfDecimalPlaces: Int = 2,
        currencySymbol: String? = nil,
        font: UIFont? = nil,
        foregroundColor: UIColor? = nil,
        accentColor: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        contentType: UITextContentType? = nil,
        autocorrection: UITextAutocorrectionType = .default,
        autocapitalization: UITextAutocapitalizationType = .sentences,
        keyboardType: UIKeyboardType = .decimalPad,
        returnKeyType: UIReturnKeyType = .default,
        isSecure: Bool = false,
        isUserInteractionEnabled: Bool = true,
        clearsOnBeginEditing: Bool = false,
        locale : Locale,
        onReturn: @escaping () -> Void = {},
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self._value = value
        self.placeholder = placeholder
        self.isResponder = isResponder
        self.tag = tag
        self.alwaysShowFractions = alwaysShowFractions
        self.numberOfDecimalPlaces = numberOfDecimalPlaces
        self.currencySymbol = currencySymbol
        
        self.font = font
        self.foregroundColor = foregroundColor
        self.accentColor = accentColor
        self.textAlignment = textAlignment
        self.contentType = contentType
        self.autocorrection = autocorrection
        self.autocapitalization = autocapitalization
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.isSecure = isSecure
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.clearsOnBeginEditing = clearsOnBeginEditing
        self.locale = locale
        self.onReturn = onReturn
        self.onEditingChanged = onEditingChanged
    }
    public init(
        _ placeholder: String = "",
        value: Binding<Double?>,
        isResponder: Binding<Bool>? = nil,
        tag: Int = 0,
        alwaysShowFractions: Bool = false,
        numberOfDecimalPlaces: Int = 2,
        currencySymbol: String? = nil,
        font: UIFont? = nil,
        foregroundColor: UIColor? = nil,
        accentColor: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        contentType: UITextContentType? = nil,
        autocorrection: UITextAutocorrectionType = .default,
        autocapitalization: UITextAutocapitalizationType = .sentences,
        keyboardType: UIKeyboardType = .decimalPad,
        returnKeyType: UIReturnKeyType = .default,
        isSecure: Bool = false,
        isUserInteractionEnabled: Bool = true,
        clearsOnBeginEditing: Bool = false,
        onReturn: @escaping () -> Void = {},
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self._value = value
        self.placeholder = placeholder
        self.isResponder = isResponder
        self.tag = tag
        self.alwaysShowFractions = alwaysShowFractions
        self.numberOfDecimalPlaces = numberOfDecimalPlaces
        self.currencySymbol = currencySymbol
        
        self.font = font
        self.foregroundColor = foregroundColor
        self.accentColor = accentColor
        self.textAlignment = textAlignment
        self.contentType = contentType
        self.autocorrection = autocorrection
        self.autocapitalization = autocapitalization
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.isSecure = isSecure
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.clearsOnBeginEditing = clearsOnBeginEditing
        self.onReturn = onReturn
        self.onEditingChanged = onEditingChanged
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CurrencyTextField>) -> UITextField {
        
        let textField = UITextField()
        textField.delegate = context.coordinator
        
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        
        // initial value
        if let v = self.value {
            textField.text = v.currencyFormat(decimalPlaces: self.numberOfDecimalPlaces, forceShowDecimalPlaces: self.alwaysShowFractions, currencySymbol: self.currencySymbol,locale : locale ?? .current)
        }
        
        // tag
        textField.tag = self.tag
        
        // font
        if let f = context.environment.font {
            switch f {
            case .largeTitle:
                textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            case .title:
                textField.font = UIFont.preferredFont(forTextStyle: .title1)
            case .body:
                textField.font = UIFont.preferredFont(forTextStyle: .body)
            case .headline:
                textField.font = UIFont.preferredFont(forTextStyle: .headline)
            case .subheadline:
                textField.font = UIFont.preferredFont(forTextStyle: .subheadline)
            case .callout:
                textField.font = UIFont.preferredFont(forTextStyle: .callout)
            case .footnote:
                textField.font = UIFont.preferredFont(forTextStyle: .footnote)
            case .caption:
                textField.font = UIFont.preferredFont(forTextStyle: .caption1)
            default:
                textField.font = font
            }
        } else {
            textField.font = font
        }
        
        // alignment
        var ltr = true
        if context.environment.layoutDirection == .rightToLeft{
            ltr = false
        }
        switch context.environment.multilineTextAlignment {
        case .center :
            textField.textAlignment = .center
        case .leading:
            textField.textAlignment = ltr ? .left : .right
        case .trailing:
            textField.textAlignment = ltr ? .right : .left
        }
        
        if let textAlignment = textAlignment {
            textField.textAlignment = textAlignment
        }
        
        // color
        textField.textColor = UIColor.label
        if let fgc = self.foregroundColor {
            textField.textColor = fgc
        }
        
        // other
        textField.placeholder = placeholder
        textField.textContentType = contentType
        textField.tintColor = accentColor
        
        textField.autocorrectionType = autocorrection
        textField.autocapitalizationType = autocapitalization
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        
        textField.clearsOnBeginEditing = clearsOnBeginEditing
        textField.isSecureTextEntry = isSecure
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textField
    }
    
    public func makeCoordinator() -> CurrencyTextField.Coordinator {
        Coordinator(value: $value, isResponder: self.isResponder, alwaysShowFractions: self.alwaysShowFractions, numberOfDecimalPlaces: self.numberOfDecimalPlaces, currencySymbol: self.currencySymbol, locale: locale ?? .current, onReturn: self.onReturn){ flag in
            self.onEditingChanged(flag)
        }
    }
    
    public func updateUIView(_ textField: UITextField, context: UIViewRepresentableContext<CurrencyTextField>) {
        
        // value
        if self.value != context.coordinator.internalValue {
            if self.value == nil {
                textField.text = nil
            } else {
                textField.text = self.value!.currencyFormat(decimalPlaces: self.numberOfDecimalPlaces, forceShowDecimalPlaces: self.alwaysShowFractions, currencySymbol: self.currencySymbol,locale : locale ?? .current)
            }
        }
        
        // set first responder ONCE
        // other times, let textfield handle it
        if self.isResponder?.wrappedValue == true && !textField.isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            textField.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
        
        // to dismiss, use dismissKeyboard()
        // don't uiView.resignFirstResponder()
        // otherwise many uibugs when using NavigationView
    }
    
    public static func dismantleUIView(_ uiView: UITextField, coordinator: CurrencyTextField.Coordinator) {
        // nothing to cleanup
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var value: Double?
        private var isResponder: Binding<Bool>?
        private var onReturn: ()->()
        private var alwaysShowFractions: Bool
        private var numberOfDecimalPlaces: Int
        private var currencySymbol: String?
        private var locale : Locale
        
        var internalValue: Double?
        var onEditingChanged: (Bool)->()
        var didBecomeFirstResponder = false
        
        
        init(value: Binding<Double?>,
             isResponder: Binding<Bool>?,
             alwaysShowFractions: Bool,
             numberOfDecimalPlaces: Int,
             currencySymbol: String?,
             locale : Locale,
             onReturn: @escaping () -> Void = {},
             onEditingChanged: @escaping (Bool) -> Void = { _ in }
        ) {
            print("coordinator init")
            _value = value
            internalValue = value.wrappedValue
            self.isResponder = isResponder
            self.alwaysShowFractions = alwaysShowFractions
            self.numberOfDecimalPlaces = numberOfDecimalPlaces
            self.currencySymbol = currencySymbol
            self.locale = locale
            self.onReturn = onReturn
            self.onEditingChanged = onEditingChanged
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // get new value
            let originalText = textField.text
            let text = textField.text as NSString?
            let newValue = text?.replacingCharacters(in: range, with: string)
            let display = newValue?.currencyFormat(decimalPlaces: self.numberOfDecimalPlaces, currencySymbol: self.currencySymbol,locale : locale)
            
            // validate change
            if !shouldAllowChange(oldValue: textField.text ?? "", newValue: newValue ?? "") {
                return false
            }
            
            // update binding variable
            self.value = newValue?.double ?? 0
            self.internalValue = value
            
            // don't move cursor if nothing changed (i.e. entered invalid values)
            if textField.text == display && string.count > 0 {
                return false
            }
            
            // update textfield display
            textField.text = display
            
            // calculate and update cursor position
            // update cursor position
            let beginningPosition = textField.beginningOfDocument
            
            var numberOfCharactersAfterCursor: Int
            if string.count == 0 && originalText == display {
                // if deleting and nothing changed, use lower bound of range
                // to allow cursor to move backwards
                numberOfCharactersAfterCursor = (originalText?.count ?? 0) - range.lowerBound
            } else {
                numberOfCharactersAfterCursor = (originalText?.count ?? 0) - range.upperBound
            }
            
            let offset = (display?.count ?? 0) - numberOfCharactersAfterCursor
            
            let cursorLocation = textField.position(from: beginningPosition, offset: offset)
            
            if let cursorLoc = cursorLocation {
                /**
                 Shortly after new text is being pasted from the clipboard, UITextField receives a new value for its
                 `selectedTextRange` property from the system. This new range is not consistent to the formatted text and
                 calculated caret position most of the time, yet it's being assigned just after setCaretPosition call.
                 
                 To insure correct caret position is set, `selectedTextRange` is assigned asynchronously.
                 (presumably after a vanishingly small delay)
                 */
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    textField.selectedTextRange = textField.textRange(from: cursorLoc, to: cursorLoc)
                }
            }
            
            // prevent from going to didChange
            // all changes to textfield already made
            return false
        }
        
        func shouldAllowChange(oldValue: String, newValue: String) -> Bool {
            // return if already has decimal
            if newValue.numberOfDecimalPoints > 1 {
                return false
            }
            
            // limits integers length
            if newValue.integers.count > 20 {
                return false
            }
            
            // limits fractions length
            if newValue.fractions?.count ?? 0 > self.numberOfDecimalPlaces {
                return false
            }
            
            return true
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isResponder?.wrappedValue = true
            }
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            textField.text = self.value?.currencyFormat(decimalPlaces: self.numberOfDecimalPlaces, forceShowDecimalPlaces: self.alwaysShowFractions, currencySymbol: self.currencySymbol,locale : locale)
            DispatchQueue.main.async {
                self.isResponder?.wrappedValue = false
            }
        }
        
        @objc func textFieldEditingDidBegin(_ textField: UITextField){
            onEditingChanged(true)
        }
        @objc func textFieldEditingDidEnd(_ textField: UITextField){
            onEditingChanged(false)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            self.onReturn()
            return true
        }
    }
}

fileprivate extension String {
    
    var numberOfDecimalPoints: Int {
        let tok = components(separatedBy: Locale.current.decimalSeparator ?? ".")
        return tok.count - 1
    }
    
    // all numbers including fractions
    var decimals: String {
        return components(separatedBy: CharacterSet(charactersIn: "0123456789" + (Locale.current.decimalSeparator ?? ".")).inverted).joined()
    }
    
    // just numbers
    var numbers: String {
        return components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
    }
    
    var integers: String {
        return decimals.components(separatedBy: Locale.current.decimalSeparator ?? ".")[0]
    }
    
    var fractions: String? {
        let split = decimals.components(separatedBy: Locale.current.decimalSeparator ?? ".")
        if split.count == 2 {
            return split[1]
        }
        return nil
    }
    
    var double: Double? {
        // uses decimals to get all numerical characters
        // then calls Double on the string
        var d = decimals
        if d.count == 0 {
            return nil
        }
        d = d.replacingOccurrences(of: ",", with: ".")
        return Double(d) ?? 0
    }
    
    // args:
    // decimalPlaces - the max number of decimal places
    func currencyFormat(decimalPlaces: Int? = nil, currencySymbol: String? = nil,locale : Locale) -> String? {
        // uses self.double
        // logic for varying the number of fraction digits
        guard let double = double else {
            return nil
        }
        
        let formatter = Formatter.currency
        formatter.locale = locale
        
        // if has fractions, show fractions
        if fractions != nil {
            // the number of decimal points in the string
            let fractionDigits = fractions?.count ?? 0
            // limited to the decimalPlaces specified in the argument
            formatter.minimumFractionDigits = min(fractionDigits, decimalPlaces != nil ? decimalPlaces! : 2)
            formatter.maximumFractionDigits = min(fractionDigits, decimalPlaces != nil ? decimalPlaces! : 2)
            
            let formatted = formatter.string(from: NSNumber(value: double))
            
            // show dot if exists
            if let formatted = formatted, fractionDigits == 0 {
                return "\(formatted)" + (Locale.current.decimalSeparator ?? ".")
            }
            
            return formatted
        }
        
        if currencySymbol != nil {
            formatter.currencySymbol = currencySymbol
        }
        
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: double))
        return formatted
    }
}

fileprivate extension Double {
    // args:
    // decimalPlaces - number of decimal places
    // forceShowDecimalPlaces - whether to force show fractions
    func currencyFormat(decimalPlaces: Int? = nil, forceShowDecimalPlaces: Bool = false, currencySymbol: String? = nil,locale : Locale) -> String? {
        let formatter = Formatter.currency
        formatter.locale = locale
        var integer = 0.0
        let d = decimalPlaces != nil ? decimalPlaces! : 2
        
        if forceShowDecimalPlaces {
            formatter.minimumFractionDigits = d
            formatter.maximumFractionDigits = d
        } else {
            // show fractions if exist
            let fraction = modf(self, &integer)
            if fraction > 0 {
                formatter.maximumFractionDigits = d
            } else {
                formatter.maximumFractionDigits = 0
            }
        }
        
        if currencySymbol != nil {
            formatter.currencySymbol = currencySymbol
        }
        
        return formatter.string(from: NSNumber(value: self))
    }
}

fileprivate struct Formatter {
    static let currency = NumberFormatter(numberStyle: .currency)
}

fileprivate extension NumberFormatter {
    convenience init(numberStyle: NumberFormatter.Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}
