//
//  OnboardingScreenEffect.swift
//  Zero
//
//  Created by Aser Eid on 02/09/2025.
//

import Foundation

enum OnboardingScreenEffect: Hashable {
    case noEffect
    case showSuccess(message: String)
    case showError(message: String)
}
