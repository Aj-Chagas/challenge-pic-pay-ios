//
//  keyboardProtocol.swift
//  picpaymobile
//
//  Created by Anderson Chagas on 14/07/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import Foundation
import UIKit


@objc protocol keyboardSelectorProtocol : AnyObject {
    
    var viewBottomConstraint : NSLayoutConstraint! { get set }
    
    var scrollView : UIScrollView! { get set }
    
    @objc
    func keyboardWillShow(_ notification: Notification)
    
    @objc
    func keyboardWillHide(_ notification: Notification)
    
    @objc func dismissKeyboard()
}


// MARK: - KeyboardProtocol

protocol KeyboardProtocol : keyboardSelectorProtocol {
    func registerForKeyboardNotification()
    func unregisterForKeyBoardNotification()
}


// MARK: - Extension KeyboardProtocol

extension KeyboardProtocol where Self: UIViewController {
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                                 selector: #selector(keyboardWillHide),
                                                 name: UIResponder.keyboardWillHideNotification,
                                                 object: nil)
    }
    
    func unregisterForKeyBoardNotification() {
        NotificationCenter.default.removeObserver(self,
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func ajustViewToShowKeyboard(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        UIView.animate(withDuration: 0.35) {
            self.updateScreenPositionForKeyboard(keyboardFrame)
        }
    }
    
    func ajustViewToHideKeyboard(_ notification: Notification, paramConstraint:CGFloat = 0.0) {
        
       UIView.animate(withDuration: 0.35) {
        self.viewBottomConstraint.constant = self.setSafeAreaBottomConstraint()
           self.view.layoutIfNeeded()
           //self.scrollView.contentInset.bottom = paramConstraint

       }
    }
    
    private func updateScreenPositionForKeyboard(_ frame: CGRect) {
        self.viewBottomConstraint.constant = frame.size.height
        self.view.layoutIfNeeded()
        //scrollView.contentInset.bottom = frame.height
    }
    
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
