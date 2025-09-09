//
//  UIColor+Extensions.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import UIKit

extension UIColor {
    public convenience init?(hexString: String?, alpha: CGFloat = 1.0) {
        guard let hexString = hexString else { return nil }
        
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if formatted.count == 6 {
            if let hex = Int(formatted, radix: 16) {
                let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
                let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
                let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
                self.init(red: red, green: green, blue: blue, alpha: alpha)} else {
                    return nil
                }
            
        } else {
            
            if let hex = Int(formatted, radix: 16) {
                let alpha = CGFloat(CGFloat((hex & 0xFF000000) >> 24)/255.0)
                let red = CGFloat(CGFloat((hex & 0x00FF0000) >> 16)/255.0)
                let green = CGFloat(CGFloat((hex & 0x0000FF00) >> 8)/255.0)
                let blue = CGFloat(CGFloat((hex & 0x000000FF) )/255.0)
                self.init(red: red, green: green, blue: blue, alpha: alpha)
            } else {
                return nil
            }
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


