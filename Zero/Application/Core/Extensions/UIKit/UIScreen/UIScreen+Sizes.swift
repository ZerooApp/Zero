//
//  UIScreen.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit.UIScreen

extension UIScreen {
    static private var current: UIScreen? { UIApplication.keyWindow?.screen }
    static var width: CGFloat { current?.bounds.width ?? 0 }
    static var height: CGFloat { current?.bounds.height ?? 0 }
}
