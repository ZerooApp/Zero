//
//  TokenModel.swift
//  Homes&
//
//  Created by Noran Fayad on 17/09/2024.
//

import Foundation

public struct TokenModel: Hashable, Codable {
    public let accessToken: String?
    public let accessTokenExpiration: Int?
    public let refreshToken: String?
    public let refreshTokenExpiration: Int?
    
    public init(accessToken: String?, accessTokenExpiration: Int?, refreshToken: String?, refreshTokenExpiration: Int?) {
        self.accessToken = accessToken
        self.accessTokenExpiration = accessTokenExpiration
        self.refreshToken = refreshToken
        self.refreshTokenExpiration = refreshTokenExpiration
    }
}


