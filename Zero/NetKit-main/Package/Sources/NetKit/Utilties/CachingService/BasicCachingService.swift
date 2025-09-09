//
//  BasicCachingService.swift
//  iOS-kernel
//
//  Created by Youssef El-Ansary on 05/04/2022.
//  Copyright © 2022 Robusta. All rights reserved.
//

import Foundation

open class BasicCachingService: CachingService {
    
    private let userDefaults: UserDefaults
    private let decodingService: DecodingService
    
    public init(userDefaults: UserDefaults,
                decodingService: DecodingService) {
        self.userDefaults = userDefaults
        self.decodingService = decodingService
    }
    
    public func cacheValue<T: Cachable>(_ value: T, forKey key: String) {
        if let stringValue = value as? String {
            let data = Data(stringValue.utf8)
            guard let encryptedData = try? CryptoManager.encryptData(data: data) else {
                userDefaults.set(value, forKey: key)
                return
            }
            userDefaults.set(encryptedData, forKey: key)
        } else {
            userDefaults.set(value, forKey: key)
        }
    }
    
    public func cacheObject<T: Encodable>(_ obj: T, forKey key: String) {
        guard let data = try? decodingService.encode(obj) else {
            print("Unable to encode data of type \(String(describing: T.self))")
            return
        }
        guard let encryptedData = try? CryptoManager.encryptData(data: data) else { return }
        userDefaults.set(encryptedData, forKey: key)
    }
    
    public func value<T: Cachable>(forKey key: String) -> T? {
        let value = userDefaults.value(forKey: key)
        if let encryptedData = value as? Data,
           let decryptedData = try? CryptoManager.decryptData(data: encryptedData),
           let stringValue = (String(data: decryptedData, encoding: .utf8) ?? "") as? T {
            return stringValue
        } else {
            return userDefaults.value(forKey: key) as? T
        }
    }
    
    public func object<T: Decodable>(forKey key: String) -> T? {
        guard let data: Data = userDefaults.value(forKey: key) as? Data else {
            print("No value found for key \(key) in UserDefaults")
            return nil
        }
        
        guard let decryptedData = try? CryptoManager.decryptData(data: data) else { return nil }
        
        guard let object = try? decodingService.decode(decryptedData, to: T.self) else {
            print("Value for \(key) found but unable to decode it to \(String(describing: T.self))")
            return nil
        }
        return object
    }
    
    public func deleteValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    public func clearCache() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
}
