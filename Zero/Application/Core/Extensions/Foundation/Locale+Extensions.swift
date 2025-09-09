//
//  Locale+Extensions.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import Foundation

extension Locale {
    static var isRTL: Bool {
        Self.current.language.languageCode?.identifier == "ar"
    }
}
