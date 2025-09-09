//
//  UserUtilities.swift
//  Magento kernel
//
//  Created by Aya Fayad on 3/24/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import Foundation

public protocol SessionService {
    /// Saves given token into Keychain
    func save(token: TokenModel)
    func loadToken() -> TokenModel?
    func removeToken()
    /// Saves given user into UserDefaults (Make sure that this object does NOT include Sensitive Data)
    func save(user: UserData)
    func loadUser() -> UserData?
    func save(userName: String)
    func loadUserName() -> String?
    func save(userType: String)
    func loadUserType() -> String?
    func removeUserType()
    func removeUser()
    func isGuest() -> Bool
    func removeAll()
}

open class AppSessionService: SessionService {
    private let basicCachingService: CachingService
    private let secureCachingService: CachingService
    
    public init(basicCachingService: CachingService,
         secureCachingService: CachingService) {
        self.basicCachingService = basicCachingService
        self.secureCachingService = secureCachingService
    }
    
    struct Keys {
        static let user = "user"
        static let userTypeKey = "userType"
        static let nameKey = "name"
        static let token = "userToken"
        static let guestCartID = "guestCartID"
    }

    public func save(token: TokenModel) {
        secureCachingService.cacheObject(token, forKey: Keys.token)
    }

    public func loadToken() -> TokenModel? {
        return secureCachingService.object(forKey: Keys.token)
    }

    public func removeToken() {
        secureCachingService.deleteValue(forKey: Keys.token)
    }

    public func save(user: UserData) {
        basicCachingService.cacheObject(user, forKey: Keys.user)
    }

    public func loadUser() -> UserData? {
        guard !isGuest() else { return nil }
        return basicCachingService.object(forKey: Keys.user)
    }

    public func removeUser() {
        basicCachingService.deleteValue(forKey: Keys.user)
    }
    
    public func save(userName: String) {
        basicCachingService.cacheValue(userName, forKey: Keys.nameKey)
    }
    
    public func loadUserName() -> String? {
        basicCachingService.value(forKey: Keys.nameKey)
    }
    
    public func save(userType: String) {
        basicCachingService.cacheValue(userType, forKey: Keys.userTypeKey)
    }
    
    public func loadUserType() -> String? {
        basicCachingService.value(forKey: Keys.userTypeKey)
    }
    
    public func removeUserType() {
        basicCachingService.deleteValue(forKey: Keys.userTypeKey)
    }

    public func isGuest() -> Bool {
        let token: TokenModel? = loadToken()
         return token == nil
    }

   public func removeAll() {
        basicCachingService.clearCache()
        secureCachingService.clearCache()
    }
}
