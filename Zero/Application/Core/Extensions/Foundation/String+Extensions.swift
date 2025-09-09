//
//  String+Extensions.swift
//  Zero
//
//  Created by Aser Eid on 03/09/2025.
//

import Foundation

extension String {
    /// Returns the localized value of the string
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    /// Returns the localized value of the string with format arguments
    func localized(with arguments: CVarArg...) -> String {
        String(format: self.localized, locale: nil, arguments: arguments)
    }
    
    var asDouble: Double { Double(self) ?? 0 }
    var asInt: Int? { Int(self) ?? 0 }
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
        
    }
}
