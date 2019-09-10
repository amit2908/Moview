//
//  NetworkLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias FetchDataFromNetworkHandler = (Data)->(Void)
class NetworkLayer {
    
    func fetchDataFromServer(handler: FetchDataFromNetworkHandler) {
            
            var urlRequest = MovieEndpoint.nowPlaying.urlRequest!
            urlRequest.timeoutInterval = 2000
            APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponse) -> (Void) in
                
                handler(nowPlayingResponse)
                
            }) { (errCode, errMsg) -> (Void) in
                self.hideProgress()
                print("Error occured: \(errCode) \(errMsg)")
            }
        
    }
    
}
