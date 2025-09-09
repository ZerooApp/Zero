//
//  ErrorModel.swift
//  Magento kernel
//
//  Created by MSZ on 2/13/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

public struct APIErrorModel: APIErrorModelProtocol {

    public var code: Int?
    public var message: String
    public var errors: [String: String]?

    public init(message: String, errors: [String: String]?) {
        self.message = message
        self.errors = errors
    }
    
    public init(code: Int, message: String, errors: [String: String]?) {
        self.message = message
        self.errors = errors
        self.code = code
    }
}

public protocol APIErrorModelProtocol: Codable {
    var code: Int? { get }
    var message: String { get }
    var errors: [String: String]? { get }

    init(message: String, errors: [String: String]?)
    init(code: Int, message: String, errors: [String: String]?)
}
