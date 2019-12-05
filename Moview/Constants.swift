//
//  Constants.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import UIKit


let APP_FONT_NAME = "AcariSans"

//Dimensions

let SCREEN_WIDTH_MULTIPLIER = ((UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.width ?? 375.0) / 375.0
let SCREEN_HEIGHT_MULTIPLIER = ((UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.height ?? 812.0) / 812.0
let SCREEN_WIDTH = (UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.width ?? CGFloat(0.0)
let SCREEN_HEIGHT = (UIApplication.shared.delegate as? AppDelegate)?.window?.bounds.size.height ?? CGFloat(0.0)



struct K {
    static let API_SECURITY_KEY = Bundle.main.object(forInfoDictionaryKey: "api_key") as! String
    
    struct Server {
        static let baseURL = "https://api.themoviedb.org"
        static let API_VERSION = "/3"
        static let imageBaseURL = "https://image.tmdb.org/t/p/"
    }
    
    struct APIEndpoint {
        static let GET_REQUEST_TOKEN_END_URL = "/authentication/token/new?api_key=\(K.API_SECURITY_KEY)"
        static let CREATE_SESSION_WITH_TOKEN_END_URL = "/authentication/token/validate_with_login?api_key=\(K.API_SECURITY_KEY)"
        static let CONFIGURATION = "/configuration?api_key=\(K.API_SECURITY_KEY)"
        static let GET_MOVIES_USING_DATE_END_URL = "/discover/movie?primary_release_date.gte=%@&primary_release_date.lte=%@&api_key=\(K.API_SECURITY_KEY)" //2019-05-05
        static let GET_UPCOMING_MOVIES_END_URL = "/movie/upcoming" //2019-05-05
        static let GET_MOVIES_IN_THEATRES_END_URL = "/movie/now_playing"
        static let GET_LATEST_MOVIE = "/movie/latest"
        static let GET_MOVIE_DETAILS = "/movie/%@"
    }
    
    struct APIParameterKeys {
        static let password = "password"
        static let email = "email"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
