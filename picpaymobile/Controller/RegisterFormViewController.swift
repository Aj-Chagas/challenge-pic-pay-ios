//
//  RegisterFormViewController.swift
//  picpaymobile
//
//  Created by Anderson Chagas on 11/06/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit
import Foundation

class RegisterFormViewController: UIViewController {
    
// MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var holder: UITextField!
    @IBOutlet weak var dateDue: UITextField!
    @IBOutlet weak var CVV: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNumber.delegate = self
        holder.delegate = self
        dateDue.delegate = self
        CVV.delegate = self
        registerForKeyboardNotification()
        dismissKey()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        unregisterForKeyBoardNotification()
    }
    
}

  // MARK: - Extension KeyboardProtocol

extension RegisterFormViewController : KeyboardProtocol {
    
    func keyboardWillShow(_ notification: Notification) {
        ajustViewToShowKeyboard(notification)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        ajustViewToHideKeyboard(notification)
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - Extension UITextFieldDelegate

extension RegisterFormViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
