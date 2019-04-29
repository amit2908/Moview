//
//  Service.swift
//  Pey
//
//  Created by Empower on 05/03/19.
//  Copyright © 2019 Empower. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    
    //GET REQUEST TOKEN
    
    func getRequestToken(completion: @escaping ((_ token: String)->()), failure: @escaping ((_ statusCode: Int, _ errorMsg: String)->()) ){
       
        let url = BASE_PATH + GET_REQUEST_TOKEN_END_URL
        let headers = [
            "Content-Type":"application/json",
        ]
        
        MRWebRequest.GET(url: url, headers: headers, completion: { (result) in
            if let userResult = result as? Dictionary<String, Any> {
               
                    let res = userResult
                    if let success = res["success"] as? Bool, success == true {
                        
                        DispatchQueue.main.async {
                            completion((res["request_token"] as? String) ?? "")
                        }
                    }else {
                        DispatchQueue.main.async {
                            failure((res["errorCode"] as? Int) ?? 404, (res["message"] as? String) ?? "unknownErrorMsg".localized())
                        }
                    }
                
                
            }
        }) { (error) in
            DispatchQueue.main.async {
                failure(error?.code ?? 500, error?.localizedDescription ?? "unknownErrorMsg".localized())
            }
        }
    }
    
    //CREATE SESSION WITH TOKEN
    
    func createSession(requestToken: String, username: String, password: String, completion: @escaping ()->(), failure: @escaping (_ errorCode: Int, _ errorMessage: String)->() ){
        let url = BASE_PATH + CREATE_SESSION_WITH_TOKEN_END_URL
        let headers = [
            "Content-Type" : "application/json"
        ]
        
        let params = [
            "username": "shubham.ojha",
            "password": "shubham123",
            "request_token": requestToken
        ]
        
        MRWebRequest.POST(url: url, authType: MRWebRequestAuthorizationType.none , headers: headers, params: params, completion: { (result) in
            if let sessionResult = result as? Dictionary<String, Any> {
            
                    let res = sessionResult
                    if let success = res["success"] as? Bool, success == true {
                        
                        DispatchQueue.main.async {
                            completion()
                        }
                    }else {
                        DispatchQueue.main.async {
                            failure((res["errorCode"] as? Int) ?? 404, (res["message"] as? String) ?? "unknownErrorMsg".localized())
                        }
                    }
            }
        }) { (error) in
            DispatchQueue.main.async {
                failure(error?.code ?? 500, error?.localizedDescription ?? "unknownErrorMsg".localized())
            }
        }
        
    }
    
    
    func fetchUpcomingMovies(fromDate: String, toDate: String,completion: @escaping ()->(), failure: @escaping (_ errorCode: Int, _ errorMessage: String)->() ){
        let url = BASE_PATH + GET_UPCOMING_MOVIES_END_URL
        
        MRWebRequest.GET(url: url, completion: { (result) in
            if let moviesResult = result as? Dictionary<String, Any> {
                
                let res = moviesResult
                if let results = res["results"] {
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }else {
                    DispatchQueue.main.async {
                        failure((res["errorCode"] as? Int) ?? 404, (res["message"] as? String) ?? "unknownErrorMsg".localized())
                    }
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                failure(error?.code ?? 500, error?.localizedDescription ?? "unknownErrorMsg".localized())
            }
        }
    }
    
    func fetchMoviesInTheatre(fromDate: String, toDate: String,completion: @escaping ()->(), failure: @escaping (_ errorCode: Int, _ errorMessage: String)->() ){
        let url = BASE_PATH + GET_MOVIES_IN_THEATRES_END_URL
        
        MRWebRequest.GET(url: url, completion: { (result) in
            if let moviesResult = result as? Dictionary<String, Any> {
                
                let res = moviesResult
                if let results = res["results"] {
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }else {
                    DispatchQueue.main.async {
                        failure((res["errorCode"] as? Int) ?? 404, (res["message"] as? String) ?? "unknownErrorMsg".localized())
                    }
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                failure(error?.code ?? 500, error?.localizedDescription ?? "unknownErrorMsg".localized())
            }
        }
    }
}
