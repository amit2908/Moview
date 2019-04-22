//
//  Constants.swift
//  Moview
//
//  Created by Empower on 22/04/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

let API_KEY = Bundle.main.object(forInfoDictionaryKey: "api_key") as! String
let BASE_PATH = "https://api.themoviedb.org/3"
let GET_REQUEST_TOKEN_END_URL = "/authentication/token/new?api_key=\(API_KEY)"
let CREATE_SESSION_WITH_TOKEN_END_URL = "/authentication/token/validate_with_login?api_key=\(API_KEY)"

let APP_FONT_NAME = "Times New Roman"
