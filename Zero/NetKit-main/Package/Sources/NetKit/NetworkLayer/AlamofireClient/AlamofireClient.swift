//
//  AlamofireClient.swift
//  PremiereCinemas
//
//  Created by Youssef El-Ansary on 13/03/2022.
//  Copyright © 2022 Robusta. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireClient {
    
    private lazy var session = createAlamofireSession()
    private let interceptor: AlamofireRequestInterceptor
    
    init(interceptor: AlamofireRequestInterceptor) {
        self.interceptor = interceptor
    }
    
    func request(_ request: URLRequest) -> DataRequest {
        session.request(request)
    }
    
    private func createAlamofireSession() -> Alamofire.Session {
        let monitor = AlamofireMonitor()
        let serviceTrustManager = getServiceTrustManager()
        let session = Session(
            configuration: getURLSessionConfiguration(),
            interceptor: interceptor,
            serverTrustManager: serviceTrustManager,
            eventMonitors: [monitor]
        )
        #if RELEASE
        return session
        #elseif PRODUCTION
        return session
        #else
        return Session(configuration: getURLSessionConfiguration(),
                              interceptor: interceptor,
                              eventMonitors: [monitor])
        #endif
    }

    //SSL Pinning for Production/Release only
    private func getServiceTrustManager() -> ServerTrustManager? {
        let evaluators: [String: ServerTrustEvaluating] = [
            "backend.homes-uat.robustastudio.com":
                PinnedCertificatesTrustEvaluator(
                    certificates: [Certificates.certificate],
                    acceptSelfSignedCertificates: false,
                    performDefaultValidation: true,
                    validateHost: true)
        ]

        let serverTrustManager = ServerTrustManager(evaluators: evaluators)
        return serverTrustManager
    }

    private func getURLSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.af.default
        let timeoutInterval = Double(Environment().configuration(.timeoutInterval) as String)!
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.timeoutIntervalForResource = timeoutInterval
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.allowsCellularAccess = true
        return configuration
    }
}

extension Alamofire.Request {
    var statusCode: Int? {
        (task?.response as? HTTPURLResponse)?.statusCode
    }
}

private struct Certificates {
    static let certificate: SecCertificate = Certificates.certificate(
        filename: "SSLcertificate")

    private static func certificate(filename: String) -> SecCertificate {
        let filePath = Bundle.main.path(forResource: filename, ofType: "der")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let certificate = SecCertificateCreateWithData(nil, data as CFData)!

        return certificate
    }
}
