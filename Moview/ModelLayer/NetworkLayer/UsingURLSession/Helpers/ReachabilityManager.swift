//
//  ReachabilityManager.swift
//  Moview
//
//  Created by Empower on 01/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    
    static let shared : NetworkManager = NetworkManager()
    
    
    private var reachability : Reachability
    
    override init() {
        self.reachability = Reachability(hostname: "www.apple.com")!
        try? self.reachability.startNotifier()
        super.init()
    }
    
    //MARK: CHECK NETWORK REACHABILITY
    
    public func isReachable(completionHandler:@escaping (Bool, _ connectionType: Reachability.Connection)->()) ->() {
        
        if reachability.connection == .none {
            completionHandler(false, Reachability.Connection.none)
        }else if reachability.connection == .wifi {
            completionHandler(true, Reachability.Connection.wifi)
        }else { // if reachability?.connection == .cellular
            completionHandler(true, Reachability.Connection.cellular)
        }
    
    }
    
    public func startNotifier(){
        try? self.reachability.startNotifier()
    }
    
    public func stopNotifier(){
        self.reachability.stopNotifier()
    }
    
    
    
}

enum InternetSpeed : String {
    case VeryGood = "veryGood";
    case Good = "good";
    case Average = "average";
    case Bad = "bad";
    case VeryBad = "veryBad"
}

extension NetworkManager {
    
    /*
     Check the internet speed of the network
     */
    
    public func checkInternetSpeed(completionHandler: @escaping (_ speed: InternetSpeed) -> Void ){
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf")
        let urlRequest = URLRequest(url: url!)
        let start = CFAbsoluteTimeGetCurrent()
        urlSession.downloadTask(with: urlRequest) { (url, response, error) in
            let diff = CFAbsoluteTimeGetCurrent() - start
            print("Took \(diff) seconds")
            
            if (error != nil) {
                completionHandler(.VeryBad)
            }else {
                if diff <= 1 {
                    completionHandler(.VeryGood)
                }else if diff > 1 && diff <= 3 {
                    completionHandler(.Good)
                }else if diff > 3 && diff <= 7 {
                    completionHandler(.Average)
                }else if diff > 7 && diff <= 15 {
                    completionHandler(.Bad)
                }else {
                    completionHandler(.VeryBad)
                }
            }
        }.resume()
    }
    
    @objc func timerStarted() {
        print("timerStarted")
    }
}
