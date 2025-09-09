//
//  SplashScreenEffect.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import Foundation

enum SplashScreenEffect: Hashable {
    case noEffect
    case showSuccess(message: String)
    case showError(message: String)
}
