//
//  CacheTokenUseCase.swift
//  Homes&
//
//  Created by Ahmed Tarek on 06/01/2025.
//

import BackgroundTasks

public protocol CacheTokenUseCase {
    func execute(token: TokenModel) async throws
}

public class CacheTokenUseCaseImp: BaseUseCase, CacheTokenUseCase {
    private let sessionService: SessionService
    
    public init(sessionService: SessionService) {
        self.sessionService = sessionService
    }
    
    public func execute(token: TokenModel) async throws {
        sessionService.save(token: token)
        //schedule token refresh using background task
        if let expirationDate = token.accessTokenExpirationDate {
            print("Access Token Expiration Date: \(expirationDate)")
            scheduleTokenRefreshTask(expirationDate: expirationDate)
        }
    }
    
    private func scheduleTokenRefreshTask(expirationDate: Date) {
        let request = BGAppRefreshTaskRequest(identifier: "com.homesand.refreshToken")
        request.earliestBeginDate = expirationDate - (30 * 60) // 30 minutes before expiration
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Background Task Refresh Token Scheduled!")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
}

private extension TokenModel {
    var accessTokenExpirationDate: Date? {
        if let accessTokenExpiration {
            return Date(timeIntervalSince1970: TimeInterval(accessTokenExpiration))
        }
        return nil
    }
}
