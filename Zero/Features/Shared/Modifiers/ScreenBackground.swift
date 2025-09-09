//
//  ScreenBackground.swift
//  Zero
//
//  Created by Aser Eid on 03/09/2025.
//

import SwiftUI

extension View {
    func screenBackground() -> some View {
        background(
            Colors.screenBackground,
            ignoresSafeAreaEdges: .all
        )
    }
}
