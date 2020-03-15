//
//  APIRouter.swift
//  Moview
//
//  Created by Empower on 24/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

