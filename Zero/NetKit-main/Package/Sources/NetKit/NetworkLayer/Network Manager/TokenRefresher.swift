//
//  TokenRefresher.swift
//  iOS-kernel
//
//  Created by Youssef El-Ansary on 11/04/2022.
//  Copyright © 2022 Robusta. All rights reserved.
//

import Alamofire
import Foundation

typealias AppResult<T> = Swift.Result<T, Error>

public class TokenRefresher {
    
    struct NotificationName {
        static let sessionExpired = NSNotification.Name("sessionExpiredChanged")
    }
    
    private let mapper: RefreshTokenMapper
    private let sessionService: SessionService
    private let decodingService: DecodingService
    private(set) var isRefreshing = false
    private let lock: NSLock
    
    private let cacheTokenUseCase: CacheTokenUseCase
    
    public init(
        sessionService: SessionService,
        decodingService: DecodingService,
        cacheTokenUseCase: CacheTokenUseCase
    ) {
        self.sessionService = sessionService
        self.decodingService = decodingService
        self.mapper = RefreshTokenMapper()
        self.lock = NSLock()
        self.cacheTokenUseCase = cacheTokenUseCase
    }
    
    /// Refreshes token and saves it to the current session
    public func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        self.refreshToken { (res: AppResult<TokenModel>) in
            switch res {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    /// Refreshes token and saves it to the current session
    func refreshToken(completion: @escaping (AppResult<TokenModel>) -> Void) {
        guard !isRefreshing else { return }
        lock.lock(); defer { lock.unlock() }
        guard let refreshToken = sessionService.loadToken()?.refreshToken else {
            let failureMsg = "Refresh Token Not Found"
            let error: APIManagerError = .refreshTokenError(failureMsg)
            completion(.failure(error))
            print(failureMsg)
            return
        }
        isRefreshing = true
        print("[OperationName: RefreshTokenQuery]")
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        AF.request(request.requestURL).responseData { [weak self] response in
            guard let self = self else { return }
            self.lock.lock(); defer { self.lock.unlock() }
            if let tokens = self.decodeTokens(fromResponse: response) {
                Task { [weak self] in
                    await self?.cacheTokens(tokens)
                    completion(.success(tokens))
                }
            } else {
                let statusCode = response.response?.statusCode ?? -1
                let failureMsg = "Unable to refresh token, Status Code: \(statusCode)"
                self.sessionService.removeAll()
                let error: APIManagerError = .refreshTokenError(failureMsg)
                completion(.failure(error))
                print(failureMsg)
                NotificationCenter.default.post(name: NotificationName.sessionExpired,
                                                object: nil,
                                                userInfo: nil)
            }
            self.isRefreshing = false
        }
    }
    
    /// Decodes given Alamofire response and saves tokens into current user session
    private func decodeTokens(fromResponse response: AFDataResponse<Data>) -> TokenModel? {
        if let data = response.data {
            return try? mapper.parse(data)
        } else {
            return nil
        }
    }
    
    private func cacheTokens(_ tokens: TokenModel) async {
        print("AuthTokenTestAfterRefresh: access: \(tokens.accessToken ?? ""), refresh: \(tokens.refreshToken ?? "")")
        try? await cacheTokenUseCase.execute(token: tokens)
    }
}
