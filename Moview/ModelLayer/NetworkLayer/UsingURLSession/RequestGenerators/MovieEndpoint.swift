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
    
    case upcomingMovies(page: Int)
    
    case topRated(page: Int)
    
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

        case .upcomingMovies:
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_UPCOMING_MOVIES_END_URL);
            
        case .topRated:
        return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_TOP_RATED_MOVIES_END_URL);
            
        case .latest:
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_LATEST_MOVIE);
            
        case .movieDetails(let id):
            return String(format: K.Server.API_VERSION + K.APIEndpoint.GET_MOVIE_DETAILS, id);
        }
    }
    
    private var queryParams : [URLQueryItem]? {
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
            
        case .upcomingMovies(let page):
            return [
                URLQueryItem(name: "api_key", value: K.API_SECURITY_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: String(page))
            ]
            
         case .topRated(let page):
            return [
                URLQueryItem(name: "api_key", value: K.API_SECURITY_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: String(page))
            ]
            
        default:
            return [
                URLQueryItem(name: "api_key", value: K.API_SECURITY_KEY),
                URLQueryItem(name: "language", value: "en-US"),
            ]
        }
    }
    
    var parameters: Parameters? {
        switch self {
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
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpMethod = method.rawValue
        
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: []);
            }catch {
                print("Parameter encoding failed with error: ", error)
            }
        }
        
        return urlRequest
        
    }
    
    
}
