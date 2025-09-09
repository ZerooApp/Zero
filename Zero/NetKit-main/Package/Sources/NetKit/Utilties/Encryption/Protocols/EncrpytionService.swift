//
//  EncrpytionService.swift
//  NetKit
//
//  Created by Noor El-Din Walid on 17/11/2024.
//

import Foundation

protocol EncrpytionService {
    static func encryptData(data: Data) throws -> Data
    static func decryptData(data: Data) throws -> Data
}
