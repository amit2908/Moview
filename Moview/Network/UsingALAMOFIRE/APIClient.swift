//
//  APIClient.swift
//  Moview
//
//  Created by Empower on 24/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//
//  API CALLS USING ALAMOFIRE
import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient();
    
     func nowPlaying(completion:@escaping ([Movie])->Void) {
        print(MoviesEndpoint.nowPlaying.urlRequest?.url ?? "")
        AF.request(MoviesEndpoint.nowPlaying)
            .responseJSON(queue: DispatchQueue.global(), options: .mutableContainers) { (response) in
                print(response)
                switch response.result {
                case .success(let JSON) :
                    print("Response:=====",JSON)
                    if let response = JSON as? Dictionary<String, Any>,
                        let results = response["results"] as? Array<Dictionary<String,Any>> {
                        let resultData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
                        let jsonDecoder = JSONDecoder.init()
                        let bgContext = AppDelegate.backgroundContext
                        jsonDecoder.userInfo.updateValue(bgContext, forKey: CodingUserInfoKey.managedObjectContext!)
                        let movies = try? jsonDecoder.decode([Movie].self, from: resultData ?? Data() )
                        AppDelegate.saveContext(context: bgContext)
                        completion(movies ?? [])
                    }
                    
                case .failure(let error) :
                    print("Error:======",error)
            }
//                completion(response.result)
 
        }
    }
}
