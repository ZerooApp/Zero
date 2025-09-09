//
//  UIViewController+ToastMessage.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit.UIViewController

extension UIViewController {
    // MARK: - SubViews
    var toastMessageView: ToastMessageView {
        let window = UIApplication.keyWindow ?? UIWindow()
        
        for view in self.view.subviews where view is ToastMessageView {
            return view as! ToastMessageView
        }
        
        for view in window.subviews where view is ToastMessageView {
            return view as! ToastMessageView
        }
        
        return ToastMessageView.instanceFromNib()
    }
    
    // MARK: - Core Functions
    func showSuccessMessage(_ message: String) {
        showToastMessage(message: message, state: .success)
    }
    
    func showErrorMessage(_ message: String) {
        showToastMessage(message: message, state: .error)
    }
    
    // MARK: - Private Helpers
    private func showToastMessage(
        message: String,
        state: ToastMessageView.State
    ) {
        let toastView = self.toastMessageView
        toastView.configure(
            message: message,
            state: state
        )
        toastView.display()
    }
}
