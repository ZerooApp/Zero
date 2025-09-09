//
//  UserPreferences.swift
//  Zero
//
//  Created by Aser Eid on 03/09/2025.
//

import Foundation
import NetKit

protocol UserPreferencesProtocol: AnyObject {
    var isFirstLaunch: Bool { get set }
    var isUserLoggedIn: Bool { get }
    var userToken: TokenModel? { get set }
    var userData: UserData? { get set }
    var userType: UserType? { get set }
    var name: String { get set }
    
    func saveFavoriteUnits(_ units: [String: Bool])
    func loadFavoriteUnits() -> [String: Bool]
    func saveFavoriteCount(_ count: Int)
    func loadFavoriteCount() -> Int
}

class UserPreferences: UserPreferencesProtocol {
    
    static let shared: UserPreferencesProtocol = UserPreferences()
    let sessionService: SessionService = AppSessionService(
        basicCachingService: BasicCachingService(
            userDefaults: UserDefaults(),
            decodingService: AppDecodingService(
                encodingStrategy: .useDefaultKeys,
                decodingStrategy: .useDefaultKeys)
        ),
        secureCachingService: SecureCachingService(
            keychain: KeychainSwift() ,
            decodingService: AppDecodingService(
                encodingStrategy: .useDefaultKeys,
                decodingStrategy: .useDefaultKeys
            )
        )
    )
   
    
    private init() {}
    
    var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isFirstLaunchKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isFirstLaunchKey)
        }
    }
    
    var isUserLoggedIn: Bool {
        get {
            return !sessionService.isGuest()
        }
    }
    
    var userToken: TokenModel? {
        get {
            
            //default return empty Token
            return sessionService.loadToken()
        }
        set {
            
            if let token = newValue {
                sessionService.save(token: token)
            }
            else {
                sessionService.removeAll()
            }
            
        }
    }
    
    var userData: UserData? {
        get {
            sessionService.loadUser()
        }
        set {
            if let user = newValue {
                sessionService.save(user: user)
                sessionService.save(userName: user.name ?? "")
                
            } else {
                sessionService.removeAll()
            }
        }
    }
    
    var userType: UserType? {
        get {
            if let userTypeString = sessionService.loadUserType(),
               let userType = UserType(rawValue: userTypeString) {
                return userType
            }
            
            return nil
        }
        set {
            if let newValue = newValue {
                sessionService.save(userType: newValue.rawValue)
            } else {
                // Remove the stored value when userType is nil, so that no value is saved for this key.
                sessionService.removeUserType()
            }
        }
    }
    var name: String {
        get {
            return sessionService.loadUserName() ?? ""
        }
        set {
            sessionService.save(userName: newValue)
        }
    }
    
    func saveFavoriteUnits(_ units: [String : Bool]) {
        if let unitsData = try? JSONEncoder().encode(units) {
            UserDefaults.standard.set(unitsData, forKey: Keys.favoriteUnitsKey)
        }
    }
    
    func loadFavoriteUnits() -> [String : Bool] {
        guard let unitsData = UserDefaults.standard.data(forKey: Keys.favoriteUnitsKey),
              let units = try? JSONDecoder().decode([String: Bool].self, from: unitsData) else {
            return [:]
        }
        return units
    }
    
    func saveFavoriteCount(_ count: Int) {
        UserDefaults.standard.set(count, forKey: Keys.favoriteCountKey)
    }
    
    func loadFavoriteCount() -> Int {
        UserDefaults.standard.integer(forKey: Keys.favoriteCountKey)
    }
    
}

// MARK: - Keys
extension UserPreferences {
    struct Keys {
        static let isFirstLaunchKey = "isFirstLaunch"
        static let favoriteUnitsKey = "favoriteUnits"
        static let favoriteCountKey = "favoriteCount"
    }
}
