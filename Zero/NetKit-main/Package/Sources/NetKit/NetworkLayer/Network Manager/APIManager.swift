//
//  APIManager.swift
//  Magento kernel
//
//  Created by MSZ on 2/13/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import Foundation
import Promises

class APIManager: NetworkManagerProtocol {
    
    @AppLazyInjected private var decodingService: DecodingService
    
    func perform(apiRequest: APIRequestProtocol, provider: APIRequestProviderProtocol) -> Promise<Data> {
        return call(provider: provider, apiRequest: apiRequest)
    }
    
    func perform(apiRequest: APIRequestProtocol, provider: APIRequestProviderProtocol) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            provider.perform(apiRequest: apiRequest, completion: { [weak self] result in
                guard let self = self else { return }
                let validatedResult = self.validate(result: result)
                switch validatedResult {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }

    private func call(provider: APIRequestProviderProtocol, apiRequest: APIRequestProtocol) -> Promise<Data> {
        return Promise<Data>(on: .promises) { fulfill, reject in
            print(apiRequest.requestURL)
            provider.perform(apiRequest: apiRequest, completion: { [weak self] result in
                if let result =  self?.validate(result: result) {
                    switch result {
                    case .success(let data):
                        fulfill(data)
                    case .failure(let error):
                        reject(error)
                    }
                }
            })
        }
    }

    private func validate(result: Result<Data, APIRequestProviderError>) -> Result<Data, APIManagerError> {
        
        let returnedresult: Result<Data, APIManagerError>
        
        switch result {
        case .failure(let error):
            switch error {
            case .noInternet(let message):
                returnedresult = .failure(.noInternet(message: message))
            case .server(let statusCode, let data):
                if let data = data,
                   let error = try? decodingService.decode(data, to: APIErrorModel.self) {
                    let errorWithStatusCode = APIErrorModel(code: statusCode,
                                                            message: error.message,
                                                            errors: error.errors)
                    returnedresult = .failure(.errorModel(errorModel: errorWithStatusCode))
                } else {
#if DEBUG || TEST
                    let details = "Debug mode: Error model parsing, status code: \(statusCode)"
#else
                    let details = "General Error".localized
#endif
                    returnedresult = .failure(.decodingFailed(model: "\(APIErrorModel.self)", message: details))
                }
            }
        case .success(let data):
            returnedresult = .success(data)
        }
        return returnedresult
    }

}
