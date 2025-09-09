//
//  PrimaryFillButtonStyle.swift
//  Zero
//
//  Created by Aser Eid on 03/09/2025.
//

import SwiftUI

extension ButtonStyle where Self == PrimaryFillButtonStyle {
    @MainActor
    public static func primaryFill(
        isDisabled: Bool = false,
        isLoading: Binding<Bool> = .constant(false)
    ) -> PrimaryFillButtonStyle {
        PrimaryFillButtonStyle(
            isDisabled: isDisabled,
            isLoading: isLoading
        )
    }
}

public struct PrimaryFillButtonStyle: ButtonStyle {
    // MARK: - Inputs
    let isDisabled: Bool
    @Binding var isLoading: Bool
    
    // MARK: - Body
    public func makeBody(configuration: Configuration) -> some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                configuration.label
            }
        }
        .appFont(name: .title, size: .large)
        .foregroundStyle(Colors.buttonTextPrimary)
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spaces.s12)
        .background(
            isDisabled ? Colors.buttonFillPrimary : Colors.buttonFillPrimary,
            in: .rect(cornerRadius: Radii.r8)
        )
        .pressAnimation(configuration.isPressed)
        .animation(.default, value: isDisabled)
    }
}
