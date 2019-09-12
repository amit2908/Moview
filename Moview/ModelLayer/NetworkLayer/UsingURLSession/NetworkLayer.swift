//
//  NetworkLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 03/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

typealias FetchDataFromNetworkSuccessHandler = (Data)->(Void)
typealias FetchDataFromNetworkFailureHandler = (Error)->(Void)

class NetworkLayer {
    
    func fetchNowPlayingDataFromServer(successHandler: @escaping FetchDataFromNetworkSuccessHandler,
                                       failureHandler: @escaping FetchDataFromNetworkFailureHandler) {
            
            let urlRequest = MovieEndpoint.nowPlaying.urlRequest!
        
            APIClient.shared.GET(entity: NowPlayingResponse.self, urlRequest: urlRequest, completionHandler: { (nowPlayingResponseData) -> (Void) in
                
                successHandler(nowPlayingResponseData)
                
            }) { (error) -> (Void) in
//                print("Error occured: \(errCode) \(errMsg)")
                failureHandler(error)
            }
        
    }
    
}