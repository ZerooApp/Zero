//
//  ViewLifeCycleModifier.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import SwiftUI

struct ViewLifeCycleModifier: ViewModifier {
    let didLoadAction: () -> Void
    let didAppearAction: (() -> Void)?

    @State
    private var appeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            if !appeared {
                appeared = true
                didLoadAction()
            } else {
                didAppearAction?()
            }
        }
    }
}
