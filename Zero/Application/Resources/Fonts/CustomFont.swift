//
//  CustomFont.swift
//  Zero
//
//  Created by Aser Eid on 26/03/2025.
//

import Foundation

// TODO: - Handle Arabic Font

struct CustomFont {
    
    private struct EnglishFontName {
        static let regularFont = "NotoSansArabic-Regular"
        static let mediumFont = "NotoSansArabic-Medium"
        static let semiBoldFont = "NotoSansArabic-SemiBold"
        static let boldFont = "NotoSansArabic-Bold"
    }
    
    private struct ArabicFontName {
        static let regularFont = "NotoSansArabic-Regular"
        static let mediumFont = "NotoSansArabic-Medium"
        static let semiBoldFont = "NotoSansArabic-SemiBold"
        static let boldFont = "NotoSansArabic-Bold"
    }
    
    enum FontName {
        /// Inter 700
        case title
        /// Inter 600
        case headline
        /// Inter 500
        case body
        /// Inter 400
        case caption
        
        var localized: String {
            let isRTL = Locale.isRTL
            switch self {
            case .title:
                return isRTL ? ArabicFontName.boldFont : EnglishFontName.boldFont
            case .headline:
                return isRTL ? ArabicFontName.semiBoldFont : EnglishFontName.semiBoldFont
            case .body:
                return isRTL ? ArabicFontName.mediumFont : EnglishFontName.mediumFont
            case .caption:
                return isRTL ? ArabicFontName.regularFont : EnglishFontName.regularFont
            }
        }
    }
    
    enum FontSize: CGFloat {
        /// 10
        case xSmall = 10
        /// 12
        case small = 12
        /// 14
        case medium = 14
        /// 16
        case large = 16
        /// 20
        case xLarge = 20
        /// 24
        case xxLarge = 24
        /// 56
        case xxxLarge = 56
    }
}

