//
//  MovieEndpoint.swift
//  Moview
//
//  Created by Empower on 24/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

/* Mark: Creating API ENDPOINTS TO CALL different apis using the ALAMOFIRE's APIConfiguration protocol */

import Foundation
import Alamofire

enum MoviesEndpoint : APIConfiguration {
    
    case nowPlaying
    
    case upcomingMovies(fromDate: String, toDate: String)
    
    case latest
    
    //Http method
    var method: HTTPMethod {
        switch self {
        case .nowPlaying :
            return .get
        case .upcomingMovies :
            return .get
        case .latest:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return K.Server.API_VERSION + K.APIEndpoint.GET_MOVIES_IN_THEATRES_END_URL
        case .upcomingMovies(let fromDate, let toDate):
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_UPCOMING_MOVIES_END_URL, fromDate, toDate);
        case .latest:
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_LATEST_MOVIE, "en-US");
        }
    }
    
    var queryParams : [URLQueryItem]? {
        switch self {
        case .nowPlaying:
            return [
                        URLQueryItem(name: "api_key", value: K.API_SECURITY_KEY),
                        URLQueryItem(name: "language", value: "en-US"),
                        URLQueryItem(name: "page", value: "1")
                    ]
        case .upcomingMovies:
            return nil
        case .latest:
            return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .nowPlaying:
            return [
                "api_key": K.API_SECURITY_KEY,
                "language": "en-US",
                "page" : "1"
            ]
        case .upcomingMovies:
            return nil
        case .latest:
            return nil
        }
    }
    
    //Validates a URL Request
    func asURLRequest() throws -> URLRequest {
        let url = try K.Server.baseURL.asURL()
        
        var urlComponents = URLComponents(string: url.absoluteString)!
        urlComponents.path = path
        
        if let urlQueryItems = queryParams {
            urlComponents.queryItems = urlQueryItems
        }
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpMethod = method.rawValue
//        urlRequest.setValue(ContentType.json.rawValue
//            , forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
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
