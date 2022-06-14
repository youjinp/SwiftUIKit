//
//  File.swift
//  
//
//  Created by Youjin Phea on 27/06/20.
//

import SwiftUI
import ContactsUI

/**
Presents a CNContactPickerViewController view modally.

- Parameters:
    - showPicker: Binding variable for presenting / dismissing the picker VC
    - onSelectContact: Use this callback for single contact selection
    - onSelectContacts: Use this callback for multiple contact selections
*/
public struct ContactPicker: UIViewControllerRepresentable {
    @Binding var showPicker: Bool
    @State private var viewModel = ContactPickerViewModel()
    public var onSelectContact: ((_: CNContact) -> Void)?
    public var onSelectContacts: ((_: [CNContact]) -> Void)?
    public var onCancel: (() -> Void)?
    
    public init(showPicker: Binding<Bool>, onSelectContact: ((_: CNContact) -> Void)? = nil, onSelectContacts: ((_: [CNContact]) -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self._showPicker = showPicker
        self.onSelectContact = onSelectContact
        self.onSelectContacts = onSelectContacts
        self.onCancel = onCancel
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ContactPicker>) -> ContactPicker.UIViewControllerType {
        let dummy = _DummyViewController()
        viewModel.dummy = dummy
        return dummy
    }
    
    public func updateUIViewController(_ uiViewController: _DummyViewController, context: UIViewControllerRepresentableContext<ContactPicker>) {

        guard viewModel.dummy != nil else {
            return
        }
        
        // able to present when
        // 1. no current presented view
        // 2. current presented view is being dismissed
        let ableToPresent = viewModel.dummy.presentedViewController == nil || viewModel.dummy.presentedViewController?.isBeingDismissed == true
        
        // able to dismiss when
        // 1. cncpvc is presented
        let ableToDismiss = viewModel.vc != nil
        
        if showPicker && viewModel.vc == nil && ableToPresent {
            let pickerVC = CNContactPickerViewController()
            pickerVC.delegate = context.coordinator
            viewModel.vc = pickerVC
            viewModel.dummy.present(pickerVC, animated: true)
        } else if !showPicker && ableToDismiss {
            viewModel.dummy.dismiss(animated: true)
            self.viewModel.vc = nil
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        if self.onSelectContacts != nil {
            return MultipleSelectionCoordinator(self)
        } else {
            return SingleSelectionCoordinator(self)
        }
    }
    
}

public final class SingleSelectionCoordinator: NSObject, Coordinator {
    var parent : ContactPicker
    
    init(_ parent: ContactPicker){
        self.parent = parent
    }
    
    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        parent.showPicker = false
        parent.onCancel?()
    }
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        parent.showPicker = false
        parent.onSelectContact?(contact)
    }
}

public final class MultipleSelectionCoordinator: NSObject, Coordinator {
    var parent : ContactPicker
    
    init(_ parent: ContactPicker){
        self.parent = parent
    }
    
    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        parent.showPicker = false
        parent.onCancel?()
    }
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        parent.showPicker = false
        parent.onSelectContacts?(contacts)
    }
}

class ContactPickerViewModel {
    var dummy: _DummyViewController!
    var vc: CNContactPickerViewController?
}

public protocol Coordinator: CNContactPickerDelegate {}

public class _DummyViewController: UIViewController {}
