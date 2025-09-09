//
//  RefreshTokenMapper.swift
//  Mazaya
//
//  Created by Ahmed Hussein on 14/08/2023.
//  Copyright © 2023 Robusta. All rights reserved.
//

import Foundation

class RefreshTokenMapper: BaseMapper<TokenModel> {
    private struct RefreshTokenResponse: Decodable {
        let data: CustomerTokenResponse?
    }
    
    private struct CustomerTokenResponse: Decodable {
        let accessToken: String
        let accessTokenExpiresAt: Int
        let refreshToken: String
        let refreshTokenExpiresAt: Int
    }
    
    override func parse(_ data: Data) throws -> TokenModel {
        let response: RefreshTokenResponse = try decode(data: data)
        let data = response.data
        return TokenModel(accessToken: data?.accessToken, accessTokenExpiration: data?.accessTokenExpiresAt, refreshToken: data?.refreshToken, refreshTokenExpiration: data?.refreshTokenExpiresAt)
    }
}
