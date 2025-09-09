//
//  ButtonPressAnimation.swift
//  Zero
//
//  Created by Aser Eid on 03/09/2025.
//

import SwiftUI

extension View {
    func pressAnimation(_ isPressed: Bool) -> some View {
        self
            .scaleEffect(isPressed ? 0.9 : 1)
            .opacity(isPressed ? 0.9 : 1)
            .animation(.bouncy, value: isPressed)
    }
}
