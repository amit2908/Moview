//
//  APIClient.swift
//  Moview
//
//  Created by Empower on 24/05/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
//import Alamofire

class APIClient {
    static let shared = APIClient();
    
    //MARK: This was for Alamofire
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

    //MARK: but now using URLSESSION
    ///HANDLE GET API WITH GENERICS
    func GET<T:Decodable>(entity withEntityType: T.Type, urlRequest: URLRequest,
                          completionHandler: ((_ entity : T )->(Void))?,
                          failureHandler: ((_ errorCode: Int, _ errorMsg : String)->(Void))? ){
        print("URLRequest URL ========> \(String(describing: urlRequest.httpMethod!)) ",  urlRequest.url!)
        if let httpBody = urlRequest.httpBody {
            try? print("URLRequest params ========> ", JSONSerialization.jsonObject(with: httpBody, options: .allowFragments))
        }
        print("URLRequest headers ========> ", urlRequest.allHTTPHeaderFields!)
        let urlSession = URLSession(configuration: .ephemeral)
        urlSession.dataTask(with: urlRequest){ (data, response, error) in
            print("HTTPData =============> ", data ?? "Data was nil.")
            if let httpResponse = response as? HTTPURLResponse,
                let responseData = data {
                if httpResponse.statusCode == 200 {
                    let jsonDecoder = JSONDecoder()
                    let bgContext = DataLayer.backgroundContext
                    jsonDecoder.userInfo.updateValue(bgContext, forKey: CodingUserInfoKey.managedObjectContext!)
                    var jsonObject : T?
                    do {
                        jsonObject = try jsonDecoder.decode(T.self, from: responseData)
                    }catch {
                        failureHandler?(400 ,error.localizedDescription)
                        print(error)
                        return
                    }
                    
                    if let res = jsonObject {
                        print("Response:============: \(res)")
                        DataLayer.saveContext(context: bgContext)
                        completionHandler?(res)
                    }else {
                        print("Failed decoding response")
                    }
                }else {
                    failureHandler?(httpResponse.statusCode, error?.localizedDescription ?? "Unknown error")
                }
            }else if let httpError = error {
                print("HTTPError =============> ", httpError.localizedDescription, httpError)
                failureHandler?(404, httpError.localizedDescription )
            }
        }.resume()
        
    }
}
