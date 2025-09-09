//
//  CryptoManager.swift
//  NetKit
//
//  Created by Noor El-Din Walid on 17/11/2024.
//

import Foundation

final class CryptoManager: EncrpytionService {
    private static let encryptionKey = Bundle.main.object(forInfoDictionaryKey: "ENCRYPTION_KEY") as? String ?? ""
    private static let crypto = CryptoUtility()
    
    static func encryptData(data: Data) throws -> Data {
        try crypto.encrypt(data: data, password: encryptionKey)
    }

    static func decryptData(data: Data) throws -> Data {
        try crypto.decrypt(encryptedData: data, password: encryptionKey)
    }
}
