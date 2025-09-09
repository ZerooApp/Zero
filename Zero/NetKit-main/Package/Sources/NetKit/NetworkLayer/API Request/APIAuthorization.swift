//
//  APIAuthorization.swift
//  Magento kernel
//
//  Created by MSZ on 2/13/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import Foundation

public enum APIAuthorization {
    
    case none
    case bearerToken
    case refreshToken
    
    var authData: [String: String] {
        switch self {
        case .none:
            return [:]
        case .bearerToken:
            let sessionService: SessionService = AppResolver.resolve()
            
            let token = sessionService.loadToken()
            if let accessToken = token?.accessToken {
                return ["Authorization": "Bearer \(accessToken)"]
            }
            return [:]
            
        case .refreshToken:
            let sessionService: SessionService = AppResolver.resolve()
            
            let token = sessionService.loadToken()
            if let refreshToken = token?.refreshToken {
                return ["Authorization": "Bearer \(refreshToken)"]
            }
            return [:]
        }
    }
}
