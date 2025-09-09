//
//  AppUIFont.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit.UIFont

extension UIFont {
    static func appFont(name: CustomFont.FontName, size: CustomFont.FontSize) -> UIFont {
        UIFont(name: name.localized, size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
}
