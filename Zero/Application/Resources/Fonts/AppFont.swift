//
//  AppFont.swift
//  Zero
//
//  Created by Aser Eid on 02/09/2025.
//

import SwiftUI

extension View {
    func appFont(name: CustomFont.FontName, size: CustomFont.FontSize) -> some View {
        modifier(AppFont(name: name, size: size))
    }
}

fileprivate struct AppFont: ViewModifier {
    // MARK: - Inputs
    let name: CustomFont.FontName
    let size: CustomFont.FontSize
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .font(.custom(name.localized, size: size.rawValue))
    }
}
