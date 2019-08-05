//
//  APIConfiguration.swift
//  Moview
//
//  Created by Shubham Ojha on 04/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation


public enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete  = "DELETE"
    case get     = "GET"
    case head    = "HEAD"
    case options = "OPTIONS"
    case patch   = "PATCH"
    case post    = "POST"
    case put     = "PUT"
    case trace   = "TRACE"
}

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

protocol URLRequestConvertable {
    /// Returns a `URLRequest` or throws if an `Error` was encoutered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws: Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertable {
    /// The `URLRequest` returned by discarding any `Error` encountered.
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

protocol APIConfig: URLRequestConvertable {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
