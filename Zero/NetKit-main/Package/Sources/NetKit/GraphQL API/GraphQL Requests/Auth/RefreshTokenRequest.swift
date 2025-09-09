//
//  RefreshTokenRequest.swift
//  Magento kernel
//
//  Created by Aya Fayad on 6/17/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import Foundation

class RefreshTokenRequest: BaseAPIRequest {
    
    private let refreshToken: String
    
    init(refreshToken: String) {
        self.refreshToken = refreshToken
        super.init()
        method = .post
        path = "/api/v1/auth/refresh-token"
        authorization = .refreshToken
    }
    
}
