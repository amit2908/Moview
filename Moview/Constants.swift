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

let API_KEY = Bundle.main.object(forInfoDictionaryKey: "api_key") as! String

let BASE_PATH = "https://api.themoviedb.org/3"
let GET_REQUEST_TOKEN_END_URL = "/authentication/token/new?api_key=\(API_KEY)"
let CREATE_SESSION_WITH_TOKEN_END_URL = "/authentication/token/validate_with_login?api_key=\(API_KEY)"

let GET_UPCOMING_MOVIES_END_URL = "/discover/movie?primary_release_date.gte=%@&primary_release_date.lte=%@&api_key=\(API_KEY)" //2019-05-05
let GET_MOVIES_IN_THEATRES_END_URL = "/movie/now_playing?api_key=\(API_KEY)&language=en-US&page=1"
