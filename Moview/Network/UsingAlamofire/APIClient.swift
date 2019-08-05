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
    
     /*func nowPlaying(completion:@escaping ([Movie])->Void) {
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
    }*/
    
//    func nowPlaying(completion:@escaping ([Movie])->Void) {
//        print(MoviesEndpoint.nowPlaying.urlRequest?.url ?? "")
//
//    }

    ///HANDLE GET API WITH GENERICS
    func GET<T:Decodable>(entity withEntityType: T.Type, urlRequest: URLRequest,
                          completionHandler: ((_ entity : T )->(Void))?,
                          failureHandler: ((_ errorCode: Int, _ errorMsg : String)->(Void))? ){
        
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: urlRequest){ (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse,
                let responseData = data {
                if httpResponse.statusCode == 200 {
                    let jsonDecoder = JSONDecoder()
                    let bgContext = AppDelegate.backgroundContext
                    jsonDecoder.userInfo.updateValue(bgContext, forKey: CodingUserInfoKey.managedObjectContext!)
                    var jsonObject : T?
                    do {
                        jsonObject = try jsonDecoder.decode(T.self, from: responseData)
                    }catch {
                        print(error)
                    }
                    
                    if let res = jsonObject {
                        completionHandler?(res)
                    }else {
                        print("Failed decoding response")
                    }
                }else {
                    failureHandler?(httpResponse.statusCode, error?.localizedDescription ?? "Unknown error")
                }
            }else if let httpError = error {
                failureHandler?(404, httpError.localizedDescription )
            }
        }.resume()
        
    }
}
