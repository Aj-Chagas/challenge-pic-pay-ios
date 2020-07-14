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
        viewBottomConstraint.constant = setSafeAreaBottomConstraint()
        
        self.dismissKey()
    }
    
    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        unregisterForKeyBoardNotification()
    }
    
    func setSafeAreaBottomConstraint(minusSafeArea : CGFloat = 0) -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            if let safeAreaBottom = window?.safeAreaInsets.bottom {
                return safeAreaBottom - minusSafeArea
            }
        }
        return minusSafeArea
    }
    
}

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    
    }
}

extension RegisterFormViewController : KeyboardProtocol {
    
    func keyboardWillShow(_ notification: Notification) {
        ajustViewToShowKeyboard(notification)
        scrollView.isScrollEnabled = true
    }
    
    func keyboardWillHide(_ notification: Notification) {
        ajustViewToHideKeyboard(notification, paramConstraint: self.setSafeAreaBottomConstraint())
        scrollView.contentInset = UIEdgeInsets.zero
        
    }
    
}

extension RegisterFormViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
