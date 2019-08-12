//
//  MovieEndpoint.swift
//  Moview
//
//  Created by Shubham Ojha on 04/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

enum MovieEndpoint : APIConfig {
    
    case nowPlaying
    
    case upcomingMovies(fromDate: String, toDate: String)
    
    case latest
    
    case movieDetails(movieId: String)
    
    //Http method
    var method: HTTPMethod {
        switch self {
        default:
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
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_LATEST_MOVIES, "en-US");
        case .movieDetails(let id):
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_MOVIE_DETAILS, id);
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
            
        case .movieDetails:
            return [
                URLQueryItem(name: "api_key", value: K.API_SECURITY_KEY)
            ]
        default:
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
        default:
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
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                print("Parameter encoding failed with error: ", error)
            }
        }
        
        return urlRequest
        
    }
    
    
}
