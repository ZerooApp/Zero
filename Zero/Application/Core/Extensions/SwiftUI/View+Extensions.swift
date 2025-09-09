//
//  View+Extensions.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import SwiftUI

extension View {
    var isRightToLeft: Bool {
        UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    func withRightToLeftSupport() -> some View {
        environment(\.layoutDirection, isRightToLeft ? .rightToLeft : .leftToRight)
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func modify(@ViewBuilder _ transform: (Self) -> (some View)?) -> some View {
        if let view = transform(self), !(view is EmptyView) {
            view
        } else {
            self
        }
    }
    
    func viewDidLoad(didLoadAction: @escaping () -> Void,
                     willAppearAction: (() -> Void)? = nil) -> some View {
        modifier(ViewLifeCycleModifier(didLoadAction: didLoadAction,
                                       didAppearAction: willAppearAction))
    }
}
