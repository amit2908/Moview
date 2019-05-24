//
//  MovieEndpoint.swift
//  Moview
//
//  Created by Empower on 24/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesEndpoint : APIConfiguration {
    
    case nowPlaying
    
    case upcomingMovies(fromDate: String, toDate: String)
    
    
    //Http method
    var method: HTTPMethod {
        switch self {
        case .nowPlaying :
            return .get
        case .upcomingMovies :
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return K.APIEndpoint.GET_MOVIES_IN_THEATRES_END_URL
        case .upcomingMovies(let fromDate, let toDate):
            return String(format: K.APIEndpoint.GET_UPCOMING_MOVIES_END_URL, fromDate, toDate);
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .nowPlaying:
            return nil
        case .upcomingMovies:
            return nil
        }
    }
    
    //Validates a URL Request
    func asURLRequest() throws -> URLRequest {
        let url = try K.Server.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue
            , forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: []);
            }catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
        
    }
    
    
}
