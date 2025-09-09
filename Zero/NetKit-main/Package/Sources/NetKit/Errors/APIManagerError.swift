//
//  APIManagerError.swift
//  Magento kernel
//
//  Created by MSZ on 2/13/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

public protocol LocalizedDescriptionError: Error {
    var description: String { get }
    var message: String { get }
    var statusCode: Int { get }
}

public enum APIManagerError: LocalizedDescriptionError {
    
    case requestFailed(message: String)
    case errorModel(errorModel: APIErrorModel)
    case noInternet(message: String)
    case refreshTokenError(_ reason: String)
    case decodingFailed(model: String?, message: String?)
    case unknown

    public var description: String {
        return switch self {
        case .requestFailed: "requestFailed"
        case .errorModel: "errorModel"
        case .noInternet: "noInternet"
        case .refreshTokenError: "refreshTokenError"
        case .decodingFailed: "decodingFailed"
        case .unknown: "unknown"
        }
    }
    
    public var message: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .errorModel(let errorModel):
            return errorModel.errors?.first?.value ?? errorModel.message
        case .noInternet(let message):
            return message
        case .refreshTokenError(let reason):
            return reason
        case .decodingFailed(_, let message):
            return message ?? "General Error".localized
        case .unknown:
            return "General Error".localized
        }
    }
    
    public var modelToDecode: String? {
        return switch self {
        case .errorModel(let errorModel):
            String(describing: errorModel.self)
        case .decodingFailed(let model, _):
            model
        default:
            nil
        }
    }
    
    public var statusCode: Int {
        switch self {
        case .requestFailed:
            return -2
        case .errorModel(let errorModel):
            return errorModel.code ?? 0
        case .noInternet:
            return 5005
        case .refreshTokenError:
            return 401
        case .decodingFailed: 
            return 200
        case .unknown:
            return 0
        }
    }
}
