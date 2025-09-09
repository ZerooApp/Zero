//
//  Image + Extensions.swift
//  Zero
//
//  Created by Test on 07/09/2025.
//

import SwiftUI

extension Image {
    func fitSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}
