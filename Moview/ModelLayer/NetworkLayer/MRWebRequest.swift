//
//  MRWebRequest.swift
//  MyRescribe
//
//  Created by Hardik Jain on 31/05/17.
//  Copyright © 2017 Hardik Jain. All rights reserved.
//

import UIKit
import Alamofire

let DEBUG_REQUEST: Bool = true
let DEBUG_RESPONSE: Bool = true


enum MRWebRequestAuthorizationType {
    case none
    case basic
    case bearer
}

enum MRWebRequestMethodType {
    case get
    case post
    case put
    case delete
    case patch
}


class MRWebRequest: NSObject {
    
    //To handle the req body use the following var
    static var reqParam = ""
    
    class func Request(Url: NSURL, methodType: MRWebRequestMethodType = .get, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil, params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        var req = URLRequest(url: Url as URL)
        switch methodType {
        case .get:
            req.httpMethod = "GET"
        case .post:
            req.httpMethod = "POST"
        case .put:
            req.httpMethod = "PUT"
        case .delete:
            req.httpMethod = "DELETE"
        case .patch:
            req.httpMethod = "PATCH"
        }
        
       //To do
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch authType {
        case .none:
//            req.setValue("", forHTTPHeaderField: "Authorization")
            break
        case .basic:
            let username = "AYmEvE3hNt1sIhScAfXNG0dYYbxzFN5aqZQCbmEMym4frbVmkhN26NHqEZzmfzxzfpZfxPNy54WxZMTF"
            let password = "EAqjtYedOcxxaMC4joazKRcTYmQCYmioOzr-LEAusJefst563aqG1hdQFDqhVD5RTCkuW6Q7-kumUr3Y"
            
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            req.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            break
        case .bearer:
            //let token = Utility.getUserLocalObjectForKey(key: "Set Key") as! String
            req.setValue("Bearer" + " " + "Set token", forHTTPHeaderField: "Authorization")
            break
        }
        
        //Set headers
        if let _headers = headers {
            for header in _headers {
                req.setValue(header.1, forHTTPHeaderField: header.0)
            }
        }
        
        //Handle req body
        if self.reqParam.count > 1 {
            let dat = reqParam.data(using: String.Encoding.ascii, allowLossyConversion: false)
            req.httpBody = dat
        }
        else {
            //Set body
            if methodType != .get {
                if let p = params {
                    req.httpBody = try! JSONSerialization.data(withJSONObject: p, options: [])
                }
            }
        }
        
        if DEBUG_REQUEST {
            print("Request Headers : \(String(describing: req.allHTTPHeaderFields))")  // original URL request
            if let p = params {
                print("Request Params : \(p)\n")
            }
        }
        
        
        request(req).responseJSON { response in
            
            if DEBUG_RESPONSE {
                
                print("Response Headers : \(String(describing: response.response))") // URL response
                print("Response Result : \(response.result)")   // result of response serialization (Success/Failure)
//                print("Response Data : \(String(describing: response.data))")     // server data
                
                if let res = String.init(data: response.data!, encoding: String.Encoding.utf8) {
                    print("Response Result Data : \(res))")
                }
            }
            
            switch response.result {
            case .success:
                if let res = response.result.value {
                    completion(res as Any?)
                }
            case .failure(let error):
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    if let res = response.result.value {
                        completion(res as Any?)
                    }
                    else {
                        completion([] as Any?)
                    }
                }
                else {
                    if DEBUG_RESPONSE {
                        print("Error: \(error)")
                    }
                    failure(error as NSError?)
                }
            }
        }
    }
    
    class func createMultipart(params: [String: Any],headers: [String: Any], url: String, image: Data, fileType:String, imageName: String, completion: @escaping (_ result: Any) -> Void, failure: @escaping (_ failure: (Error)) -> Void){
        
        // use SwiftyJSON to convert a dictionary to JSON
//        let parameterJSON = JSON(params)
//        // JSON stringify
//        let parameterString = parameterJSON.rawString(String.Encoding.utf8, options: .prettyPrinted)//rawString(encoding: NSUTF8StringEncoding, options: nil)
//        _ = parameterString!.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
//        print("Params: \(params)")
//        print("Headers: \(headers)")
//        print("Url - \(url)")
//        print("data - \(image)")
//        print("File type - \(fileType), ImageName - \(imageName)")
        
        var fileName = String()
        var mimeType = String()
        
        if fileType == "IMG" {
            fileName = "\(imageName).jpg"
            mimeType = "image/jpg"
        } else if fileType == "PDF" {
            mimeType = "application/pdf"
            fileName = "\(imageName).pdf"
        } else if fileType == "AUD" {
            mimeType = "audio/x-caf"
            fileName = "\(imageName).caf"
        }
        Alamofire.upload(multipartFormData:{ multipartFormData in multipartFormData.append(image, withName: imageName, fileName: fileName, mimeType: mimeType)}, usingThreshold:UInt64.init(), to:url, method:.post, headers:headers as? HTTPHeaders, encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Progress : \(progress)")
                    
                })
                upload.responseJSON { response in
//                    let json = JSON(response)
                    print("json:: \(response)")
                    debugPrint(response)
                    if let res = response.result.value {
                        completion(res as Any)
                    }
                }
            case .failure(let encodingError):
                failure(encodingError)
                break
            }
        })
    }
    
    class func GET(url: String, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil,  params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        MRWebRequest.Request(Url: NSURL(string: url)!, methodType: .get, authType: authType, headers: headers, params: params, completion: completion, failure: failure)
    }
    
    class func POST(reqParam: String ,url: String, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil,  params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        MRWebRequest.reqParam = reqParam
        MRWebRequest.Request(Url: NSURL(string: url)!, methodType: .post, authType: authType, headers: headers, params: params, completion: completion, failure: failure)
    }
    
    class func POST(url: String, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil,  params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        MRWebRequest.Request(Url: NSURL(string: url)!, methodType: .post, authType: authType, headers: headers, params: params, completion: completion, failure: failure)
    }
    
    class func PUT(url: String, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil,  params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        MRWebRequest.Request(Url: NSURL(string: url)!, methodType: .put, authType: authType, headers: headers, params: params, completion: completion, failure: failure)
    }
    
    class func DELETE(url: String, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil,  params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        MRWebRequest.Request(Url: NSURL(string: url)!, methodType: .delete, authType: authType, headers: headers, params: params, completion: completion, failure: failure)
    }
    
    class func PATCH(url: String, authType: MRWebRequestAuthorizationType = .none, headers: [String: String]? = nil,  params: [String: Any]? = nil, completion: @escaping (_ result: Any?) -> Void, failure: @escaping (_ error: NSError?) -> Void) {
        
        MRWebRequest.Request(Url: NSURL(string: url)!, methodType: .patch, authType: authType, headers: headers, params: params, completion: completion, failure: failure)
    }
}
