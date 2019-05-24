//
//  APIClient.swift
//  Moview
//
//  Created by Empower on 24/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient();
    
     func nowPlaying(completion:@escaping (Result<Movie>)->Void) {
        AF.request(MoviesEndpoint.nowPlaying)
            .responseDecodable { (response: DataResponse<Movie>) in
                completion(response.result)
        }
    }
}
