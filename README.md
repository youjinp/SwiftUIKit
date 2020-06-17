# SwiftUIKit, a collection of missing SwiftUI components

There is an example app at `SwiftUIKitExampleApp` which can be built and run.

# CurrencyTextField
## Demo
![Currency Text Field Demo](demo/currencyTextField.gif)

## Description
Real time formatting of users input into currency format.

## Usage
```swift
struct ContentView: View {
  @State private var value = 0.0
  var body: some View {
    CurrencyTextField("Amount", value: self.$value)
      .font(.largeTitle)
      .multilineTextAlignment(TextAlignment.center)
  }
}
```

# AdaptToKeyboard
## Demo
![Adapt to keyboard demo](demo/keyboardAdapt.gif)

## Description
Animate view's position when keyboard is shown / hidden

## Usage
```swift
someView()
    .adaptToKeyboard()
```
