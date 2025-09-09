//
//  UIApplication+Window.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit.UIApplication

extension UIApplication {
    static var keyWindow: UIWindow? {
        shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }
    
    static var keyWindowScene: UIWindowScene? {
        shared.connectedScenes.first as? UIWindowScene
    }
    
    static var rootVC: UIViewController? {
        get {
            keyWindow?
                .rootViewController
        }
        set {
            if let window =  UIApplication.keyWindow {
                window.rootViewController = newValue
                UIView.transition(
                    with: window,
                    duration: 0.2,
                    options: .transitionCrossDissolve,
                    animations: nil,
                    completion: nil
                )
            }
        }
    }
    
}
