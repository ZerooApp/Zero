//
//  CryptoError.swift
//  NetKit
//
//  Created by Noor El-Din Walid on 17/11/2024.
//


import Foundation
import CommonCrypto

enum CryptoError: Error {
    case keyError
    case ivError
    case cryptoError
    case dataError
    case encodingError
}

final class CryptoUtility {
    // MARK: - Constants
    private let keySize = kCCKeySizeAES256
    private let ivSize = kCCBlockSizeAES128
    private let saltSize = 8
    private let pbkdIterations = 10000
    
    // MARK: - Public Methods
    
    /// Encrypts data using AES-256 encryption
    /// - Parameters:
    ///   - data: Data to encrypt
    ///   - password: Password for encryption
    /// - Returns: Encrypted data
    func encrypt(data: Data, password: String) throws -> Data {
        // Generate a random salt
        let salt = try generateRandomBytes(length: saltSize)
        
        // Derive key and IV from password and salt
        let (key, iv) = try deriveKeyAndIV(password: password, salt: salt)
        
        // Perform the encryption
        let encrypted = try performCipher(data: data,
                                        key: key,
                                        iv: iv,
                                        operation: CCOperation(kCCEncrypt))
        
        // Combine salt + IV + encrypted data
        var combined = Data()
        combined.append(salt)
        combined.append(iv)
        combined.append(encrypted)
        
        return combined
    }
    
    /// Decrypts data using AES-256 decryption
    /// - Parameters:
    ///   - encryptedString: Base64 encoded encrypted string
    ///   - password: Password for decryption
    /// - Returns: Decrypted data
    func decrypt(encryptedData: Data, password: String) throws -> Data {
        
        // Extract salt, IV, and encrypted data
        let salt = encryptedData.subdata(in: 0..<saltSize)
        let iv = encryptedData.subdata(in: saltSize..<(saltSize + ivSize))
        let encrypted = encryptedData.subdata(in: (saltSize + ivSize)..<encryptedData.count)
        
        // Derive key and IV from password and salt
        let (key, _) = try deriveKeyAndIV(password: password, salt: salt)
        
        // Perform the decryption
        return try performCipher(data: encrypted,
                               key: key,
                               iv: iv,
                               operation: CCOperation(kCCDecrypt))
    }
    
    // MARK: - Private Methods
    
    private func generateRandomBytes(length: Int) throws -> Data {
        var bytes = [UInt8](repeating: 0, count: length)
        let status = SecRandomCopyBytes(kSecRandomDefault, length, &bytes)
        
        guard status == errSecSuccess else {
            throw CryptoError.cryptoError
        }
        
        return Data(bytes)
    }
    
    private func deriveKeyAndIV(password: String, salt: Data) throws -> (key: Data, iv: Data) {
        guard let passwordData = password.data(using: .utf8) else {
            throw CryptoError.encodingError
        }
        
        let derivedKeyLength = keySize + ivSize
        var derivedBytes = [UInt8](repeating: 0, count: derivedKeyLength)
        
        let derivationStatus = salt.withUnsafeBytes { saltBytes in
            passwordData.withUnsafeBytes { passwordBytes in
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    passwordBytes.baseAddress?.assumingMemoryBound(to: Int8.self),
                    passwordData.count,
                    saltBytes.baseAddress?.assumingMemoryBound(to: UInt8.self),
                    salt.count,
                    CCPBKDFAlgorithm(kCCPRFHmacAlgSHA256),
                    UInt32(pbkdIterations),
                    &derivedBytes,
                    derivedKeyLength
                )
            }
        }
        
        guard derivationStatus == kCCSuccess else {
            throw CryptoError.keyError
        }
        
        let key = Data(derivedBytes[0..<keySize])
        let iv = Data(derivedBytes[keySize..<derivedKeyLength])
        
        return (key, iv)
    }
    
    private func performCipher(data: Data, key: Data, iv: Data, operation: CCOperation) throws -> Data {
        let outputLength = data.count + kCCBlockSizeAES128
        var outputBuffer = [UInt8](repeating: 0, count: outputLength)
        var numBytesProcessed = 0
        
        let cryptStatus = key.withUnsafeBytes { keyBytes in
            iv.withUnsafeBytes { ivBytes in
                data.withUnsafeBytes { dataBytes in
                    CCCrypt(
                        operation,
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress,
                        keySize,
                        ivBytes.baseAddress,
                        dataBytes.baseAddress,
                        data.count,
                        &outputBuffer,
                        outputLength,
                        &numBytesProcessed
                    )
                }
            }
        }
        
        guard cryptStatus == kCCSuccess else {
            throw CryptoError.cryptoError
        }
        
        return Data(outputBuffer[0..<numBytesProcessed])
    }
}
