//
//  UserData.swift
//  Homes&
//
//  Created by Noran Fayad on 19/09/2024.
//

import Foundation

public struct UserData: Hashable, Codable {
    public let id: String?
    public let phone: String?
    public let name: String?
    public let email: String?
    public let countryCode: String?
    
    public init(id: String?, phone: String?, name: String?, email: String?, countryCode: String?) {
            self.id = id
            self.phone = phone
            self.name = name
            self.email = email
            self.countryCode = countryCode
        }
}
